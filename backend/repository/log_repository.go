package repository

import (
	"context"
	"database/sql"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/models"
)

type LogRepository interface {
	Create(ctx context.Context, line *models.Log) (int64, error)
}

type postgresLogRepository struct {
	db *sql.DB
}

func NewPostgresLogRepository(db *sql.DB) LogRepository {
	return &postgresLogRepository{db: db}
}

func (r *postgresLogRepository) Create(ctx context.Context, log *models.Log) (int64, error) {
	query := `
	INSERT INTO log
	    (created_at, disruption_id) 
	VALUES ($1, $2) 
	RETURNING id`
	row := r.db.QueryRowContext(ctx, query,
		log.CreatedAt, log.DisruptionID)
	err := row.Scan(&log.ID)
	if err != nil {
		return 0, fmt.Errorf("failed to create log: %v", err)
	}
	return log.ID, nil
}
