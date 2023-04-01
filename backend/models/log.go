package models

import "time"

type Log struct {
	ID           int64     `db:"id"`
	DisruptionID int64     `db:"disruption_id"`
	CreatedAt    time.Time `db:"created_at"`
}
