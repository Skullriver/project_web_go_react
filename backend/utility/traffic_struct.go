package utility

import "time"

type TrafficResponse []struct {
	Line Line `json:"line"`
}
type Message struct {
	Title       string `json:"title"`
	Description string `json:"description"`
}
type Disruptions struct {
	ID               string  `json:"id"`
	Effect           string  `json:"effect"`
	Color            string  `json:"color"`
	Message          Message `json:"message"`
	UpdatedAt        string  `json:"updated_at"`
	CreatedAt        string  `json:"created_at"`
	ApplicationStart string  `json:"application_start"`
	ApplicationEnd   string  `json:"application_end"`
}
type Line struct {
	ID           int64         `json:"id"`
	Code         string        `json:"code"`
	Name         string        `json:"name"`
	Color        string        `json:"color"`
	TextColor    string        `json:"text_color"`
	PhysicalMode string        `json:"physical_mode"`
	Disruptions  []Disruptions `json:"disruptions"`
	ClosingTime  string        `json:"closing_time"`
	OpeningTime  string        `json:"opening_time"`
}

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
	CreatedAt        time.Time `db:"created_at"`
}
