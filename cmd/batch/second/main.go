package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
)

// Response struct defines the structure of the JSON output
type Response struct {
	Number int `json:"number"`
}

func main() {
	// コマンドライン引数の設定
	numberPtr := flag.Int("number", 0, "an integer number (default: 0)")

	// コマンドライン引数の解析
	flag.Parse()

	// Create a response from the provided number
	response := Response{Number: *numberPtr}

	// Convert the response struct to JSON
	jsonData, err := json.Marshal(response)
	if err != nil {
		log.Fatalf("Failed to convert to JSON: %v", err)
	}

	// Print the JSON response
	fmt.Println(string(jsonData))
}
