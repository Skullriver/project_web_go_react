package repository

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/models"
)

var ErrNoLine = errors.New("no line found")

type LineRepository interface {
	CreateLine(ctx context.Context, line *models.Line) (int64, error)
	GetLineByLineID(ctx context.Context, id string) (*models.Line, error)
	GetLines(ctx context.Context) ([]*models.Line, error)
}

type postgresLineRepository struct {
	db *sql.DB
}

func NewPostgresLineRepository(db *sql.DB) LineRepository {
	return &postgresLineRepository{db: db}
}

func (r *postgresLineRepository) CreateLine(ctx context.Context, line *models.Line) (int64, error) {
	query := `
	INSERT INTO lines 
	    (line_id, code, name, color, text_color, physical_mode, closing_time, opening_time) 
	VALUES ($1, $2, $3, $4, $5, $6, $7, $8) 
	RETURNING id`
	row := r.db.QueryRowContext(ctx, query,
		line.LineID, line.Code, line.Name,
		line.Color, line.TextColor, line.PhysicalMode, line.ClosingTime, line.OpeningTime)
	err := row.Scan(&line.ID)
	if err != nil {
		return 0, fmt.Errorf("failed to create line: %v", err)
	}
	return line.ID, nil
}

func (r *postgresLineRepository) GetLineByLineID(ctx context.Context, id string) (*models.Line, error) {
	query := "SELECT * FROM lines WHERE line_id = $1"
	row := r.db.QueryRowContext(ctx, query, id)
	line := &models.Line{}
	err := row.Scan(&line.ID, &line.LineID, &line.Code, &line.Name, &line.Color, &line.TextColor, &line.ClosingTime, &line.OpeningTime, &line.PhysicalMode)
	if err == sql.ErrNoRows {
		return nil, ErrNoLine
	}
	if err != nil {
		return nil, fmt.Errorf("failed to get line: %v", err)
	}
	return line, nil
}

func (r *postgresLineRepository) GetLines(ctx context.Context) ([]*models.Line, error) {
	query := "SELECT * FROM lines ORDER BY line_id"
	rows, err := r.db.QueryContext(ctx, query)

	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var lines []*models.Line
	for rows.Next() {
		line := &models.Line{}
		er := rows.Scan(&line.ID, &line.LineID, &line.Code, &line.Name, &line.Color, &line.TextColor, &line.ClosingTime, &line.OpeningTime, &line.PhysicalMode)
		if er != nil {
			return nil, er
		}
		lines = append(lines, line)
	}

	return lines, nil
}
