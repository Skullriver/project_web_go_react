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

type BetTakingResponse struct {
	TicketID int    `json:"ticket_id"`
	Message  string `json:"Message"`
}

type ActiveBet struct {
	ID        int       `json:"id"`
	Type      int       `json:"type"`
	LimitDate time.Time `json:"limit_date"`
	QtVictory float64   `json:"qt_victory"`
	QtLoss    float64   `json:"qt_loss"`
	Status    string    `json:"status"`
	UserID    int64     `json:"user_id"`
	Username  string    `json:"username"`
}

type Ticket struct {
	ID     int       `json:"id"`
	UserID int       `json:"user_id"`
	BetID  int       `json:"bet_id"`
	Bid    bool      `json:"bid"`
	Value  float64   `json:"value"`
	Status string    `json:"status"`
	Bet    ActiveBet `json:"bet"`
}

type SelectedBet struct {
	ID              int       `json:"id"`
	Title           string    `json:"title"`
	Type            int       `json:"type"`
	MR              string    `json:"m_r"`
	Line            string    `json:"line"`
	NumType         int       `json:"num_type"`
	Value           float64   `json:"value"`
	LimitDate       time.Time `json:"limit_date"`
	QtVictory       float64   `json:"qt_victory"`
	QtLoss          float64   `json:"qt_loss"`
	Status          string    `json:"status"`
	CreatorID       string    `json:"creator_id"`
	CreatorUsername string    `json:"creator_username"`
}

type TakeBetRequest struct {
	BetID    int    `json:"bet_id"`
	Bid      string `json:"bid"`
	BetValue string `json:"bet_value"`
}
