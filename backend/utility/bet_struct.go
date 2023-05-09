package utility

import "time"

type BetCreationInfoResponse struct {
	Rer   []SimpleLine `json:"RER"`
	Metro []SimpleLine `json:"Metro"`
}
type SimpleLine struct {
	Name        string    `json:"name"`
	LineID      string    `json:"line_id"`
	ClosingTime time.Time `json:"closing_time"`
	OpeningTime time.Time `json:"opening_time"`
}

type CreateBetRequest struct {
	Title      string `json:"title"`
	Type       string `json:"type"`
	StartDay   string `json:"startDay"`
	LimitDate  string `json:"limitDate"`
	QtDefeat   string `json:"qtDefeat"`
	QtVictory  string `json:"qtVictory"`
	MR         string `json:"m_r"`
	NumType    string `json:"num_type"`
	SelectLine string `json:"selectLine"`
	Value      string `json:"value"`
}
type BetCreationResponse struct {
	BetID   int    `json:"betID"`
	Message string `json:"Message"`
}
