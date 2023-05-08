package utility

import "time"

type BetCreationResponse struct {
	Rer   []SimpleLine `json:"RER"`
	Metro []SimpleLine `json:"Metro"`
}
type SimpleLine struct {
	Name        string    `json:"name"`
	ClosingTime time.Time `json:"closing_time"`
	OpeningTime time.Time `json:"opening_time"`
}
