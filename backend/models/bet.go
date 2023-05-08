package models

import (
	"time"
)

type Bet struct {
	ID        int       `db:"id"`
	Type      int       `db:"type"`
	DateBet   time.Time `db:"date_bet"`
	LimitDate time.Time `db:"limit_date"`
	QtVictory float64   `db:"qt_victory"`
	QtLoss    float64   `db:"qt_loss"`
	Status    string    `db:"status"`
	UserID    int64     `json:"user_id"`
}
