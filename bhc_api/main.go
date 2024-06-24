package main

import (
	"database/sql"
	"fmt"
	"log/slog"
	"net/http"
	"os"

	"github.com/kitsoNamane/bhc_api/api"
	"github.com/kitsoNamane/bhc_api/data"
	_ "github.com/tursodatabase/libsql-client-go/libsql"
	"github.com/uptrace/bunrouter"
)

func main() {
	tursoUrl := "libsql://bhc-hackathon-kitsonamane.turso.io"
	tursoToken := "eyJhbGciOiJFZERTQSIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTkxNzI4MzksImlkIjoiZDI4OWYyODUtM2ZiNi00ZThjLTk3YTQtMTY1MTVlMDBkZWIwIn0.RahMj9QZ7VqxymqP8J8rEjvgOcs3GDcSqsWtB8CHb4uU2Aw5_mEXsOymDDUm2ugf93NAClsBfvPSxbw-ZQsrCA"
	url := fmt.Sprintf("%s?authToken=%s", tursoUrl, tursoToken)

	dbCon, err := sql.Open("libsql", url)
	if err != nil {
		fmt.Fprintf(os.Stderr, "failed to open db %s: %s", url, err)
		os.Exit(1)
	}

	db := data.New(dbCon)

	api := api.NewApi(db, slog.Default())

	router := bunrouter.New()

	router.GET("/api/customer", api.GetUser)
	router.POST("/api/customer", api.OnboardUser)
	http.ListenAndServe("0.0.0.0:8080", router)
}
