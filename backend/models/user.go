package models

import "golang.org/x/crypto/bcrypt"

type User struct {
    ID             int64   `json:"id"`
    Username       string  `json:"username"`
    Email          string  `json:"email"`
    Password       string  `json:"-"`
    AccountBalance float64 `json:"account_balance"`
}


func (u *User) CheckPassword(password string) bool {
    err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password))
    return err == nil
}
