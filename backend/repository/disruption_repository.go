package repository

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"github.com/Skullriver/Sorbonne_PS3R.git/models"
	"github.com/Skullriver/Sorbonne_PS3R.git/utility"
)

var ErrNoDisruption = errors.New("no disruption found")

type DisruptionRepository interface {
	CreateDisruption(ctx context.Context, disruption *models.Disruption) (int64, error)
	GetDisruptionByDisruptionID(ctx context.Context, id string) (*models.Disruption, error)
	GetDisruptionsMap(ctx context.Context) (map[string][]*utility.Disruption, error)
}

type postgresDisruptionRepository struct {
	db *sql.DB
}

func NewPostgresDisruptionRepository(db *sql.DB) DisruptionRepository {
	return &postgresDisruptionRepository{db: db}
}

func (r *postgresDisruptionRepository) CreateDisruption(ctx context.Context, disruption *models.Disruption) (int64, error) {
	query := `
	INSERT INTO disruptions 
	    (disruption_id, line_id, status, type, 
	     color, effect, title, message, updated_at, application_start, application_end) 
	VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) 
	RETURNING id`
	row := r.db.QueryRowContext(ctx, query,
		disruption.DisruptionID, disruption.LineID, disruption.Status, disruption.Type,
		disruption.Color, disruption.Effect, disruption.Title, disruption.Message,
		disruption.UpdatedAt, disruption.ApplicationStart, disruption.ApplicationEnd)
	err := row.Scan(&disruption.ID)
	if err != nil {
		return 0, fmt.Errorf("failed to create disruption: %v", err)
	}
	return disruption.ID, nil
}

func (r *postgresDisruptionRepository) GetDisruptionByDisruptionID(ctx context.Context, id string) (*models.Disruption, error) {
	query := "SELECT * FROM disruptions WHERE disruption_id = $1"
	row := r.db.QueryRowContext(ctx, query, id)
	disruption := &models.Disruption{}
	err := row.Scan(&disruption.ID,
		&disruption.DisruptionID, &disruption.LineID, &disruption.Status, &disruption.Type,
		&disruption.Color, &disruption.Effect, &disruption.Title, &disruption.Message,
		&disruption.UpdatedAt, &disruption.ApplicationStart, &disruption.ApplicationEnd)
	if err == sql.ErrNoRows {
		return nil, ErrNoDisruption
	}
	if err != nil {
		return nil, fmt.Errorf("failed to get disruption: %v", err)
	}
	return disruption, nil
}

func (r *postgresDisruptionRepository) GetDisruptionsMap(ctx context.Context) (map[string][]*utility.Disruption, error) {

	query := `
	SELECT d.*, l.created_at FROM disruptions d
	INNER JOIN log l ON d.id = l.disruption_id;`

	rows, err := r.db.QueryContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	disruptions := make(map[string][]*utility.Disruption)
	for rows.Next() {
		disruption := &utility.Disruption{}
		er := rows.Scan(&disruption.ID,
			&disruption.DisruptionID, &disruption.LineID, &disruption.Status, &disruption.Type,
			&disruption.Color, &disruption.Effect, &disruption.Title, &disruption.Message,
			&disruption.UpdatedAt, &disruption.ApplicationStart, &disruption.ApplicationEnd,
			&disruption.CreatedAt)
		if er != nil {
			return nil, er
		}

		if _, ok := disruptions[disruption.LineID]; !ok {
			disruptions[disruption.LineID] = []*utility.Disruption{}
		}

		disruptions[disruption.LineID] = append(disruptions[disruption.LineID], disruption)
	}

	return disruptions, nil
}
