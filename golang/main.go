package main

import (
	"database/sql"
	"encoding/json"
	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"syscall"
	"time"
)

type Message struct {
	streamName  string    `json:"stream_name,omitempty"`
	position    int64     `json:"position,omitempty"`
	time        time.Time `json:"time"`
	data        string    `json:"data,omitempty"`
	messageType string    `json:"message_type,omitempty"`
}

func getCategoryMessages(db *sql.DB, category string, position int64) (error, []Message) {
	rows, err := db.Query("SELECT stream_name, position, time, data, type AS message_type        FROM get_category_messages($1, $2)", category, position)
	if err != nil {
		return err, nil
	}
	defer rows.Close()
	var messages []Message
	for rows.Next() {
		msg := Message{}
		if err = rows.Scan(&msg.streamName, &msg.position, &msg.time, &msg.data, &msg.messageType); err != nil {
			return err, nil
		}
		messages = append(messages, msg)
	}
	return nil, messages
}

func main() {

	connStr := "postgresql://message_store:@localhost:5432/message_store?sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		panic(err)
	}
	db.SetMaxOpenConns(10)

	router := mux.NewRouter()

	router.HandleFunc("/category/{category}/{position}", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		vars := mux.Vars(r)
		category := vars["category"]
		position, err := strconv.ParseInt(vars["position"], 10, 64)
		if err != nil {
			panic(err)
		}
		err, msgs := getCategoryMessages(db, category, position)
		if err != nil {
			panic(err)
		}

		jsonBytes, err := json.Marshal(msgs)
		if err != nil {
			panic(err)
		}
		w.Write(jsonBytes)
	})
	http.ListenAndServe(":3000", router)

	done := make(chan os.Signal, 1)
	signal.Notify(done, os.Interrupt, syscall.SIGINT, syscall.SIGTERM)
	<-done
	err = db.Close()
	if err != nil {
		panic(err)
	}
}
