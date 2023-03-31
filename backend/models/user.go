package models

import "golang.org/x/crypto/bcrypt"

type User struct {
	ID             int64   `db:"id"`
	Username       string  `db:"username"`
	Email          string  `db:"email"`
	Password       string  `db:"password"`
	AccountBalance float64 `db:"account_balance"`
}

func (u *User) CheckPassword(password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password))
	return err == nil
}
