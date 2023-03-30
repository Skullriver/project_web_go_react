package repository

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/models"
)

var ErrNoLine = errors.New("no line found")

type TrafficRepository interface {
	CreateLine(ctx context.Context, line *models.Line) (int64, error)
	GetLineByLineID(ctx context.Context, id string) (*models.Line, error)
}

type postgresTrafficRepository struct {
	db *sql.DB
}

func NewPostgresTrafficRepository(db *sql.DB) TrafficRepository {
	return &postgresTrafficRepository{db: db}
}

func (r *postgresTrafficRepository) CreateLine(ctx context.Context, line *models.Line) (int64, error) {
	query := `
	INSERT INTO lines 
	    (line_id, code, name, color, text_color, closing_time, opening_time) 
	VALUES ($1, $2, $3, $4, $5, $6, $7) 
	RETURNING id`
	row := r.db.QueryRowContext(ctx, query,
		line.LineID, line.Code, line.Name,
		line.Color, line.TextColor, line.ClosingTime, line.OpeningTime)
	err := row.Scan(&line.ID)
	if err != nil {
		return 0, fmt.Errorf("failed to create line: %v", err)
	}
	return line.ID, nil
}

func (r *postgresTrafficRepository) GetLineByLineID(ctx context.Context, id string) (*models.Line, error) {
	query := "SELECT * FROM lines WHERE line_id = $1"
	row := r.db.QueryRowContext(ctx, query, id)
	line := &models.Line{}
	err := row.Scan(&line.ID, &line.LineID, &line.Code, &line.Name, &line.Color, &line.TextColor, &line.ClosingTime, &line.OpeningTime)
	if err == sql.ErrNoRows {
		return nil, ErrNoLine
	}
	if err != nil {
		return nil, fmt.Errorf("failed to get line: %v", err)
	}
	return line, nil
}
