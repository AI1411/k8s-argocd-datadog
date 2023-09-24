package main

import (
	"crypto/rand"
	"encoding/json"
	"fmt"
	"math/big"
)

type Response struct {
	Number int `json:"number"`
}

func main() {
	randomNumber, err := rand.Int(rand.Reader, big.NewInt(5))
	if err != nil {
		fmt.Println("Error generating random number:", err)
		return
	}
	// 0-4の範囲のため、1を加えて1-5の範囲を得る
	number := randomNumber.Int64() + 1

	response := Response{
		Number: int(number),
	}

	jsonData, err := json.Marshal(response)
	if err != nil {
		fmt.Println("Error encoding JSON:", err)
		return
	}

	fmt.Println(string(jsonData))
}
