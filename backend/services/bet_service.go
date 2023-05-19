package services

import (
	"context"
	"errors"
	"github.com/Skullriver/Sorbonne_PS3R.git/models"
	"github.com/Skullriver/Sorbonne_PS3R.git/repository"
	"github.com/Skullriver/Sorbonne_PS3R.git/utility"
	"strconv"
	"time"
)

type BetService struct {
	UserRepository       repository.UserRepository
	LineRepository       repository.LineRepository
	DisruptionRepository repository.DisruptionRepository
	LogRepository        repository.LogRepository
	BetRepository        repository.BetRepository
}

func (s *BetService) GetInfoForCreation(ctx context.Context) utility.BetCreationInfoResponse {

	lines, err := s.LineRepository.GetLines(ctx)
	if err != nil {
		return utility.BetCreationInfoResponse{}
	}

	var rerList []utility.SimpleLine
	var metroList []utility.SimpleLine

	for _, line := range lines {

		lineObj := utility.SimpleLine{}

		lineObj.Name = line.Code
		lineObj.LineID = line.LineID
		lineObj.ClosingTime = line.ClosingTime
		lineObj.OpeningTime = line.OpeningTime

		if line.PhysicalMode == "physical_mode:Metro" {
			metroList = append(metroList, lineObj)
		} else {
			rerList = append(rerList, lineObj)
		}

	}

	response := utility.BetCreationInfoResponse{
		Rer:   rerList,
		Metro: metroList,
	}

	return response
}

func (s *BetService) CreateBet(ctx context.Context, req utility.CreateBetRequest, userID int64) (int, error) {

	typeInt, err := strconv.Atoi(req.Type)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid type")
	}

	QtVictoryFloat, err := strconv.ParseFloat(req.QtVictory, 64)
	if err != nil || QtVictoryFloat > 3 || QtVictoryFloat < 1 {
		return 0, errors.New("bet creation failed: invalid QtVictory")
	}

	QtLossFloat, err := strconv.ParseFloat(req.QtDefeat, 64)
	if err != nil || QtLossFloat > 3 || QtLossFloat < 1 {
		return 0, errors.New("bet creation failed: invalid QtDefeat")
	}

	lt, err := time.Parse(time.RFC3339Nano, req.LimitDate)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid LimitDate")
	}

	st, err := time.Parse(time.RFC3339Nano, req.StartDay)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid StartDay")
	}

	if lt.After(st) || st.Equal(lt) {
		return 0, errors.New("bet creation failed: LimitDate is after StartDay")
	}

	// Load the "Europe/Paris" time zone
	location, err := time.LoadLocation("Europe/Paris")
	if err != nil {
		// Handle error
		return 0, err
	}

	// Convert the parsed time to "Europe/Paris" time zone
	lt = lt.In(location)
	st = st.In(location)

	nbBets, err := s.BetRepository.GetBetsNbForUser(ctx, userID)

	if err != nil {
		return 0, err
	}
	if nbBets >= 3 {
		return 0, errors.New("bet creation failed: you can't create more bets today")
	}

	// Create a new bet object
	bet := &models.Bet{
		Type:      typeInt,
		Title:     req.Title,
		DateBet:   st,
		LimitDate: lt,
		QtVictory: QtVictoryFloat,
		QtLoss:    QtLossFloat,
		Status:    "created",
		UserID:    userID,
		Created:   time.Now().Local(),
	}

	// Insert the new bet object into the database
	betID, err := s.BetRepository.CreateBet(ctx, bet)
	if err != nil {
		return 0, errors.New("bet creation failed: " + err.Error())
	}

	var betType repository.BetType

	switch typeInt {
	case 1:
		// Handle BetType1
		var NumTypeInt int
		if req.NumType == "%" {
			NumTypeInt = 1
		} else if req.NumType == "qty" {
			NumTypeInt = 2
		} else {
			s.BetRepository.DeleteBet(ctx, betID)
			return 0, errors.New("bet creation failed: invalid NumType")
		}
		ValueFloat, err := strconv.ParseFloat(req.Value, 64)
		if err != nil {
			s.BetRepository.DeleteBet(ctx, betID)
			return 0, errors.New("bet creation failed: invalid QtVictory")
		}
		betType = &repository.BetType1{
			ID:      betID,
			MR:      req.MR,
			NumType: NumTypeInt,
			Value:   ValueFloat,
		}
	case 2:
		// Handle BetType2
		betType = &repository.BetType2{
			ID:   betID,
			MR:   req.MR,
			Line: req.SelectLine,
		}
	case 3:
		// Handle BetType3
		ValueFloat, err := strconv.ParseFloat(req.Value, 64)
		if err != nil {
			s.BetRepository.DeleteBet(ctx, betID)
			return 0, errors.New("bet creation failed: invalid QtVictory")
		}
		betType = &repository.BetType3{
			ID:    betID,
			MR:    req.MR,
			Value: ValueFloat,
		}
	default:
		s.BetRepository.DeleteBet(ctx, betID)
		return 0, errors.New("unsupported bet type")
	}

	err = s.BetRepository.FillTypeBet(ctx, betType)

	s.BetRepository.DeleteBet(ctx, 5)

	if err != nil {
		s.BetRepository.DeleteBet(ctx, betID)
		return 0, errors.New("filling bet type failed")
	}

	balance, err := s.UserRepository.GetUserBalance(ctx, userID)
	if err != nil {
		return 0, err
	}

	err = s.UserRepository.UpdateUserBalance(ctx, balance+200, userID)
	if err != nil {
		s.BetRepository.DeleteBet(ctx, betID)
		return 0, errors.New("updating user balance failed")
	}

	return betID, nil
}

func (s *BetService) TakeBet(ctx context.Context, req utility.TakeBetRequest, userID int64) (int, error) {

	// Check if user with given email exists
	user, err := s.UserRepository.GetUserByID(ctx, userID)
	if err != nil {
		return 0, errors.New("bet taking failed: invalid userID")
	}

	//Get selected bet
	bet, err := s.GetBetByID(ctx, req.BetID)
	if err != nil {
		return 0, errors.New("bet taking failed: invalid betID")
	}

	// Check if bet's limit date is in the future
	if bet.LimitDate.Before(time.Now()) {
		return 0, errors.New("bet taking failed: limit date has passed")
	}

	betVal, err := strconv.ParseFloat(req.BetValue, 64)
	if err != nil {
		return 0, errors.New("bet taking failed: invalid bet Value")
	}

	// Check if user's balance is sufficient for the bet value
	if betVal < 200 {
		return 0, errors.New("bet taking failed: bet Value should be more than 200 ")
	}

	// Check if user's balance is sufficient for the bet value
	if betVal > user.AccountBalance {
		return 0, errors.New("bet taking failed: insufficient balance")
	}

	// Check if bid value is correct
	if req.Bid != "oui" && req.Bid != "non" {
		return 0, errors.New("bet taking failed: incorrect bid")
	}

	bid := false
	if req.Bid == "oui" {
		bid = true
	}

	// Call the createTicket function with the necessary parameters
	ticketID, err := s.BetRepository.CreateTicket(ctx, bet.ID, userID, bid, betVal)
	if err != nil {
		return 0, errors.New("bet taking failed: failed to create ticket")
	}

	balance, err := s.UserRepository.GetUserBalance(ctx, userID)
	if err != nil {
		return 0, err
	}

	err = s.UserRepository.UpdateUserBalance(ctx, balance-betVal, userID)
	if err != nil {
		return 0, errors.New("updating user balance failed")
	}

	if bet.CreatorID != strconv.FormatInt(userID, 10) {
		err = s.BetRepository.UpdateBetStatus(ctx, bet.ID, "opened")
		if err != nil {
			return 0, errors.New("updating bet status failed")
		}
	}

	// Return the ticket ID as the success result
	return ticketID, nil

}

func (s *BetService) GetActiveBets(ctx context.Context) ([]utility.ActiveBet, error) {

	bets, err := s.BetRepository.GetActiveBets(ctx)
	if err != nil {
		return nil, nil
	}

	return bets, nil
}

func (s *BetService) GetBetByID(ctx context.Context, betID int) (utility.SelectedBet, error) {

	bet, err := s.BetRepository.GetBetByID(ctx, betID)
	if err != nil {
		return utility.SelectedBet{}, nil
	}

	return bet, nil
}

func (s *BetService) GetBetsByUserID(ctx context.Context, userID int64) ([]utility.ActiveBet, error) {

	bets, err := s.BetRepository.GetBetsByUserID(ctx, userID)
	if err != nil {
		return nil, err
	}
	if bets == nil {
		bets = make([]utility.ActiveBet, 0)
	}

	return bets, nil
}

func (s *BetService) GetTicketsByUserID(ctx context.Context, userID int64) ([]utility.Ticket, error) {

	tickets, err := s.BetRepository.GetTicketsByUserID(ctx, userID)
	if err != nil {
		return nil, err
	}
	if tickets == nil {
		tickets = make([]utility.Ticket, 0)
	}

	return tickets, nil
}
