package repository

import (
	"context"
	"database/sql"
	"github.com/Skullriver/Sorbonne_PS3R.git/models"
)

type BetRepository interface {
	CreateBet(ctx context.Context, bet *models.Bet) (int, error)
	FillTypeBet(ctx context.Context, bet BetType) error
	GetBetByUserID(ctx context.Context, id int64) (*models.Bet, error)
	UpdateBet(ctx context.Context, bet *models.Bet) error
	DeleteBet(ctx context.Context, id int) error
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
	stmt, err := r.db.Prepare("INSERT INTO bets (type, date_bet, limit_date, qt_victory, qt_loss, status, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id")
	if err != nil {
		return 0, err
	}
	defer stmt.Close()

	// Execute the statement with arguments
	var id int
	err = stmt.QueryRow(bet.Type, bet.DateBet, bet.LimitDate, bet.QtVictory, bet.QtLoss, bet.Status, bet.UserID).Scan(&id)
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

func (r *postgresBetRepository) GetBetByUserID(ctx context.Context, id int64) (*models.Bet, error) {

	return &models.Bet{}, nil
}

func (r *postgresBetRepository) UpdateBet(ctx context.Context, bet *models.Bet) error {
	return nil
}

func (r *postgresBetRepository) DeleteBet(ctx context.Context, id int) error {
	_, err := r.db.ExecContext(ctx, "DELETE FROM bet WHERE id = $1", id)
	if err != nil {
		return err
	}

	return nil
}
