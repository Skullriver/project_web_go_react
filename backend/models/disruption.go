package models

import "time"

type Disruption struct {
	ID               int64     `db:"id"`
	DisruptionID     string    `db:"disruption_id"`
	LineID           string    `db:"line_id"`
	Status           string    `db:"status"`
	Type             string    `db:"type"`
	Color            string    `db:"color"`
	Effect           string    `db:"effect"`
	Title            string    `db:"title"`
	Message          string    `db:"message"`
	UpdatedAt        time.Time `db:"updated_at"`
	ApplicationStart time.Time `db:"application_start"`
	ApplicationEnd   time.Time `db:"application_end"`
}
