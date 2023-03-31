package models

import "time"

type Line struct {
	ID          int64     `db:"id"`
	LineID      string    `db:"line_id"`
	Code        string    `db:"code"`
	Name        string    `db:"name"`
	Color       string    `db:"color"`
	TextColor   string    `db:"text_color"`
	ClosingTime time.Time `db:"closing_time"`
	OpeningTime time.Time `db:"opening_time"`
}
