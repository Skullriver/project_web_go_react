package repository

import (
	"context"
	"database/sql"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/models"
	"github.com/Skullriver/Sorbonne_PS3R.git/utility"
	"strconv"
	"time"
)

type BetRepository interface {
	CreateBet(ctx context.Context, bet *models.Bet) (int, error)
	FillTypeBet(ctx context.Context, bet BetType) error
	GetBetsByUserID(ctx context.Context, id int64) ([]utility.ActiveBet, error)
	UpdateBetStatus(ctx context.Context, betID int, betStatus string) error
	UpdateTicketStatus(ctx context.Context, ticketID int, ticketStatus string) error
	DeleteBet(ctx context.Context, id int) error
	GetActiveBets(ctx context.Context) ([]utility.ActiveBet, error)
	GetBetByID(ctx context.Context, betID int) (utility.SelectedBet, error)
	CreateTicket(ctx context.Context, betID int, userID int64, bid bool, value float64) (int, error)
	GetTicketsByUserID(ctx context.Context, userID int64) ([]utility.Ticket, error)
	GetBetsNbForUser(ctx context.Context, userID int64) (int, error)
	GetBetsToCheck(ctx context.Context, dateStart time.Time, dateEnd time.Time) (map[int]utility.BetToCheck, error)
}

type BetType interface {
	FillTypeBet(ctx context.Context, db *sql.DB) error
}

type BetType1 struct {
	ID      int     `json:"id"`
	MR      string  `json:"m_r"`
	NumType int     `json:"num_type"`
	Value   float64 `json:"value"`
}

type BetType2 struct {
	ID   int    `json:"id"`
	MR   string `json:"m_r"`
	Line string `json:"line"`
}

type BetType3 struct {
	ID    int     `json:"id"`
	MR    string  `json:"m_r"`
	Value float64 `json:"value"`
}

type postgresBetRepository struct {
	db *sql.DB
}

func NewPostgresBetRepository(db *sql.DB) BetRepository {
	return &postgresBetRepository{db: db}
}

func (r *postgresBetRepository) CreateBet(ctx context.Context, bet *models.Bet) (int, error) {

	// Prepare the statement with placeholders
	stmt, err := r.db.Prepare(
		`INSERT INTO bets (type, title, date_bet, limit_date, 
                  qt_victory, qt_loss, status, user_id, created) 
				VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING id`)
	if err != nil {
		return 0, err
	}
	defer stmt.Close()

	// Execute the statement with arguments
	var id int
	err = stmt.QueryRow(bet.Type, bet.Title, bet.DateBet, bet.LimitDate, bet.QtVictory,
		bet.QtLoss, bet.Status, bet.UserID, bet.Created).Scan(&id)
	if err != nil {
		return 0, err
	}

	return id, nil
}

func (b *BetType1) FillTypeBet(ctx context.Context, db *sql.DB) error {

	stmt, err := db.PrepareContext(ctx, `
            INSERT INTO bet_type1 (id, m_r, num_type, value) VALUES ($1, $2, $3, $4)
        `)
	if err != nil {
		return err
	}
	_, err = stmt.ExecContext(ctx, b.ID, b.MR, b.NumType, b.Value)

	return nil
}

func (b *BetType2) FillTypeBet(ctx context.Context, db *sql.DB) error {

	stmt, err := db.PrepareContext(ctx, `
            INSERT INTO bet_type2 (id, m_r, line) VALUES ($1, $2, $3)
        `)
	if err != nil {
		return err
	}
	_, err = stmt.ExecContext(ctx, b.ID, b.MR, b.Line)
	return nil
}

func (b *BetType3) FillTypeBet(ctx context.Context, db *sql.DB) error {
	stmt, err := db.PrepareContext(ctx, `
            INSERT INTO bet_type3 (id, m_r, value) VALUES ($1, $2, $3)
        `)
	if err != nil {
		return err
	}
	_, err = stmt.ExecContext(ctx, b.ID, b.MR, b.Value)
	return nil
}

func (r *postgresBetRepository) FillTypeBet(ctx context.Context, bet BetType) error {
	return bet.FillTypeBet(ctx, r.db)
}

func (r *postgresBetRepository) GetBetsByUserID(ctx context.Context, userID int64) ([]utility.ActiveBet, error) {

	// Define the SQL query with placeholders for user ID and status
	query := `
        SELECT b.id, b.title, b.type, b.date_bet, b.limit_date, b.qt_victory, 
               b.qt_loss, b.status, b.user_id, u.username, b.created
		FROM bets b
		INNER JOIN users AS u ON b.user_id = u.id
        WHERE b.user_id = $1
    `

	// Prepare the query
	stmt, err := r.db.PrepareContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer stmt.Close()

	// Execute the query with status values
	rows, err := stmt.QueryContext(ctx, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	// Iterate over the rows and scan the values into ActiveBet structs
	var activeBets []utility.ActiveBet
	for rows.Next() {
		var activeBet utility.ActiveBet
		if err := rows.Scan(
			&activeBet.ID,
			&activeBet.Title,
			&activeBet.Type,
			&activeBet.BetDay,
			&activeBet.LimitDate,
			&activeBet.QtVictory,
			&activeBet.QtLoss,
			&activeBet.Status,
			&activeBet.UserID,
			&activeBet.Username,
			&activeBet.Created); err != nil {
			return nil, err
		}
		activeBets = append(activeBets, activeBet)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	return activeBets, nil
}

func (r *postgresBetRepository) GetBetsNbForUser(ctx context.Context, userID int64) (int, error) {
	// Get the current date
	location, err := time.LoadLocation("Europe/Paris")
	if err != nil {
		// Handle error
		return 0, err
	}
	currentDate := time.Now().In(location).Format("2006-01-02")

	// Define the SQL query with placeholders for user ID and status
	query := `
        SELECT COUNT(*) FROM bets WHERE user_id = $1 AND DATE(created) = $2
    `

	// Prepare the query
	stmt, err := r.db.PrepareContext(ctx, query)
	if err != nil {
		return 0, err
	}
	defer stmt.Close()

	// Execute the query with status values
	var count int
	err = stmt.QueryRowContext(ctx, userID, currentDate).Scan(&count)
	if err != nil {
		return 0, err
	}

	return count, nil
}

func (r *postgresBetRepository) GetTicketsByUserID(ctx context.Context, userID int64) ([]utility.Ticket, error) {

	// Define the SQL query with placeholders for user ID and status
	query := `
        SELECT t.id, t.user_id, t.bet_id, t.bid, t.value, t.status, 
               b.id, b.title, b.type, b.date_bet, b.limit_date, b.qt_victory, 
               b.qt_loss, b.status, b.user_id, u.username, b.created
		FROM tickets t
		INNER JOIN bets AS b ON t.bet_id = b.id 
		INNER JOIN users AS u ON t.user_id = u.id
        WHERE t.user_id = $1
    `

	// Prepare the query
	stmt, err := r.db.PrepareContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer stmt.Close()

	// Execute the query with status values
	rows, err := stmt.QueryContext(ctx, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	// Iterate over the rows and scan the values into ActiveBet structs
	var activeTickets []utility.Ticket
	for rows.Next() {
		var activeBet utility.ActiveBet
		var ticket utility.Ticket
		if err := rows.Scan(
			&ticket.ID,
			&ticket.UserID,
			&ticket.BetID,
			&ticket.Bid,
			&ticket.Value,
			&ticket.Status,
			&activeBet.ID,
			&activeBet.Title,
			&activeBet.Type,
			&activeBet.BetDay,
			&activeBet.LimitDate,
			&activeBet.QtVictory,
			&activeBet.QtLoss,
			&activeBet.Status,
			&activeBet.UserID,
			&activeBet.Username,
			&activeBet.Created,
		); err != nil {
			return nil, err
		}
		ticket.Bet = activeBet
		activeTickets = append(activeTickets, ticket)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	return activeTickets, nil
}

func (r *postgresBetRepository) GetBetsToCheck(ctx context.Context, dateStart time.Time, dateEnd time.Time) (map[int]utility.BetToCheck, error) {

	// Define the SQL query with placeholders for user ID and status
	query := `
        SELECT b.id, t.id, t.user_id, t.bid, t.value, t.status
		FROM bets b
		LEFT JOIN tickets AS t ON t.bet_id = b.id 
        WHERE b.date_bet >= $1 AND b.date_bet <= $2 AND b.status IN ('opened', 'created')
    `

	// Prepare the query
	stmt, err := r.db.PrepareContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer stmt.Close()

	// Execute the query with status values
	rows, err := stmt.QueryContext(ctx, dateStart, dateEnd)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	// Iterate over the rows and scan the values into ActiveBet structs
	// Map to store bets by ID
	betMap := make(map[int]utility.BetToCheck)

	for rows.Next() {
		var betID int
		var ticket utility.TicketToCheck

		var ticketID sql.NullInt64
		var userID sql.NullInt64
		var bid sql.NullString
		var value sql.NullFloat64
		var status sql.NullString

		if err := rows.Scan(
			&betID,
			&ticketID,
			&userID,
			&bid,
			&value,
			&status,
		); err != nil {
			return nil, err
		}

		// Create a new BetToCheck struct if it doesn't exist in the map
		bet, ok := betMap[betID]
		if !ok {
			bet = utility.BetToCheck{
				ID:      betID,
				Tickets: []utility.TicketToCheck{},
			}
		}

		// Check for null values and handle them accordingly
		if ticketID.Valid {
			ticket.ID = int(ticketID.Int64)
		}
		if userID.Valid {
			ticket.UserID = int(userID.Int64)
		}
		if bid.Valid {
			ticket.Bid, _ = strconv.ParseBool(bid.String)
		}
		if value.Valid {
			ticket.Value = value.Float64
		}
		if status.Valid {
			ticket.Status = status.String
		}

		// Add the ticket to the respective bet
		if ticketID.Valid {
			// Add the ticket to the respective bet
			bet.Tickets = append(bet.Tickets, ticket)
		}
		betMap[betID] = bet
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	return betMap, nil
}

func (r *postgresBetRepository) UpdateBetStatus(ctx context.Context, betID int, betStatus string) error {

	query := "UPDATE bets SET status = $1 WHERE id = $2"
	_, err := r.db.ExecContext(ctx, query, betStatus, betID)
	if err != nil {
		return fmt.Errorf("failed to update bets: %v", err)
	}
	return nil
}

func (r *postgresBetRepository) UpdateTicketStatus(ctx context.Context, ticketID int, ticketStatus string) error {

	query := "UPDATE tickets SET status = $1 WHERE id = $2"
	_, err := r.db.ExecContext(ctx, query, ticketStatus, ticketID)
	if err != nil {
		return fmt.Errorf("failed to update tickets: %v", err)
	}
	return nil
}

func (r *postgresBetRepository) DeleteBet(ctx context.Context, id int) error {
	_, err := r.db.ExecContext(ctx, "DELETE FROM bets WHERE id = $1", id)
	if err != nil {
		return err
	}

	return nil
}

func (r *postgresBetRepository) GetActiveBets(ctx context.Context) ([]utility.ActiveBet, error) {

	// Get the current date
	location, err := time.LoadLocation("Europe/Paris")

	now := time.Now().In(location)
	// Define the SQL query with placeholders for user ID and status
	query := `
        SELECT b.id, b.title, b.type, b.date_bet, b.limit_date, b.qt_victory, 
               b.qt_loss, b.status, b.user_id, u.username, b.created
        FROM bets AS b
        INNER JOIN users AS u ON b.user_id = u.id
        WHERE b.status IN ($1, $2) AND $3 < b.limit_date
		ORDER BY b.limit_date
    `

	// Prepare the query
	stmt, err := r.db.PrepareContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer stmt.Close()

	// Execute the query with status values
	rows, err := stmt.QueryContext(ctx, "created", "opened", now)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	// Iterate over the rows and scan the values into ActiveBet structs
	var activeBets []utility.ActiveBet
	for rows.Next() {
		var activeBet utility.ActiveBet
		if err := rows.Scan(
			&activeBet.ID,
			&activeBet.Title,
			&activeBet.Type,
			&activeBet.BetDay,
			&activeBet.LimitDate,
			&activeBet.QtVictory,
			&activeBet.QtLoss,
			&activeBet.Status,
			&activeBet.UserID,
			&activeBet.Username,
			&activeBet.Created,
		); err != nil {
			return nil, err
		}
		activeBets = append(activeBets, activeBet)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	return activeBets, nil
}

func (r *postgresBetRepository) GetBetByID(ctx context.Context, betID int) (utility.SelectedBet, error) {

	var selectedBet utility.SelectedBet

	query := `
		SELECT b.id, b.title, b.type, b.date_bet, b.limit_date, b.qt_victory, b.qt_loss, b.status, b.user_id, u.username
		FROM bets b
		INNER JOIN users AS u ON b.user_id = u.id
		WHERE b.id = $1
	`

	// Prepare the query
	stmt, err := r.db.PrepareContext(ctx, query)
	if err != nil {
		return utility.SelectedBet{}, err
	}
	defer stmt.Close()

	// Execute the query with status values
	row, err := stmt.QueryContext(ctx, betID)
	if err != nil {
		return utility.SelectedBet{}, err
	}
	defer row.Close()

	if !row.Next() {
		return utility.SelectedBet{}, fmt.Errorf("no rows returned for betID: %d", betID)
	}

	err = row.Scan(
		&selectedBet.ID,
		&selectedBet.Title,
		&selectedBet.Type,
		&selectedBet.BetDay,
		&selectedBet.LimitDate,
		&selectedBet.QtVictory,
		&selectedBet.QtLoss,
		&selectedBet.Status,
		&selectedBet.CreatorID,
		&selectedBet.CreatorUsername,
	)
	if err != nil {
		return utility.SelectedBet{}, err
	}

	if selectedBet.Type == 1 {

		query = `
		SELECT bt.m_r, bt.num_type, bt.value
		FROM bet_type1 bt
		WHERE bt.id = $1
	`

		// Prepare the query
		stmt, err = r.db.PrepareContext(ctx, query)
		if err != nil {
			return selectedBet, err
		}
		defer stmt.Close()

		// Execute the query with status values
		row, err = stmt.QueryContext(ctx, betID)
		if err != nil {
			return selectedBet, err
		}
		defer row.Close()

		if !row.Next() {
			return selectedBet, fmt.Errorf("no rows bet_type returned for betID: %d", betID)
		}

		err = row.Scan(
			&selectedBet.MR,
			&selectedBet.NumType,
			&selectedBet.Value,
		)
		if err != nil {
			return selectedBet, err
		}
	}

	if selectedBet.Type == 2 {

		query = `
		SELECT bt.m_r, bt.line
		FROM bet_type2 bt
		WHERE bt.id = $1
	`

		// Prepare the query
		stmt, err = r.db.PrepareContext(ctx, query)
		if err != nil {
			return selectedBet, err
		}
		defer stmt.Close()

		// Execute the query with status values
		row, err = stmt.QueryContext(ctx, betID)
		if err != nil {
			return selectedBet, err
		}
		defer row.Close()

		if !row.Next() {
			return selectedBet, fmt.Errorf("no rows bet_type returned for betID: %d", betID)
		}

		err = row.Scan(
			&selectedBet.MR,
			&selectedBet.Line,
		)
		if err != nil {
			return selectedBet, err
		}
	}

	if selectedBet.Type == 3 {

		query = `
		SELECT bt.m_r, bt.value
		FROM bet_type3 bt
		WHERE bt.id = $1
	`

		// Prepare the query
		stmt, err = r.db.PrepareContext(ctx, query)
		if err != nil {
			return selectedBet, err
		}
		defer stmt.Close()

		// Execute the query with status values
		row, err = stmt.QueryContext(ctx, betID)
		if err != nil {
			return selectedBet, err
		}
		defer row.Close()

		if !row.Next() {
			return selectedBet, fmt.Errorf("no rows bet_type returned for betID: %d", betID)
		}

		err = row.Scan(
			&selectedBet.MR,
			&selectedBet.Value,
		)
		if err != nil {
			return selectedBet, err
		}
	}

	return selectedBet, nil
}

func (r *postgresBetRepository) CreateTicket(ctx context.Context, betID int, userID int64, bid bool, value float64) (int, error) {

	query := `
		INSERT INTO tickets (user_id, bet_id, bid, value,status) VALUES ($1, $2, $3, $4, $5) RETURNING id
	`

	// Prepare the query
	stmt, err := r.db.PrepareContext(ctx, query)
	if err != nil {
		return 0, err
	}
	defer stmt.Close()

	var id int

	// Execute the query with values
	err = stmt.QueryRowContext(ctx, userID, betID, bid, value, "opened").Scan(&id)
	if err != nil {
		return 0, err
	}

	return id, nil
}
