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

	// Check if user with given email exists
	_, err := s.UserRepository.GetUserByID(ctx, userID)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid userID")
	}

	typeInt, err := strconv.Atoi(req.Type)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid type")
	}

	QtVictoryFloat, err := strconv.ParseFloat(req.QtVictory, 64)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid QtVictory")
	}

	QtLossFloat, err := strconv.ParseFloat(req.QtDefeat, 64)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid QtVictory")
	}

	lt, err := time.Parse(time.RFC3339, req.LimitDate)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid LimitDate")
	}

	st, err := time.Parse(time.RFC3339, req.StartDay)
	if err != nil {
		return 0, errors.New("bet creation failed: invalid LimitDate")
	}

	// Create a new bet object
	bet := &models.Bet{
		Type:      typeInt,
		DateBet:   st,
		LimitDate: lt,
		QtVictory: QtVictoryFloat,
		QtLoss:    QtLossFloat,
		Status:    "created",
		UserID:    userID,
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

	return betID, nil
}
