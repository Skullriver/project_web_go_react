package utility

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
