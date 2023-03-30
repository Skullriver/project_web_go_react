package models

import "time"

type Line struct {
	ID          int64     `json:"id"`
	LineID      string    `json:"line_id"`
	Code        string    `json:"code"`
	Name        string    `json:"name"`
	Color       string    `json:"color"`
	TextColor   string    `json:"text_color"`
	ClosingTime time.Time `db:"closing_time"`
	OpeningTime time.Time `db:"opening_time"`
}
