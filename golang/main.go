package main

import (
	"context"
	"encoding/json"
	"github.com/gorilla/mux"
	"github.com/jackc/pgx/v5/pgxpool"
	"net/http"
	"strconv"
	"time"
)

type Message struct {
	StreamName  string                 `json:"stream_name,omitempty"`
	Position    int64                  `json:"position,omitempty"`
	Time        time.Time              `json:"time"`
	Data        map[string]interface{} `json:"data,omitempty"`
	MessageType string                 `json:"message_type,omitempty"`
}

func getCategoryMessages(db *pgxpool.Pool, category string, position int64) (error, []Message) {
	rows, err := db.Query(context.Background(), "SELECT stream_name, position, time, data, type FROM get_category_messages($1, $2, 10)", category, position)
	if err != nil {
		return err, nil
	}
	defer rows.Close()
	var messages []Message
	for rows.Next() {
		msg := Message{}
		values, err := rows.Values()
		if err != nil {
			return err, nil
		}
		msg.StreamName = values[0].(string)
		msg.Position = values[1].(int64)
		msg.Time = values[2].(time.Time)
		json.Unmarshal([]byte(values[3].(string)), &msg.Data)
		msg.MessageType = values[4].(string)

		messages = append(messages, msg)
	}
	return nil, messages
}

func main() {

	connStr := "postgresql://message_store:@localhost:5432/message_store?sslmode=disable&pool_max_conns=80"
	pool, err := pgxpool.New(context.Background(), connStr)
	if err != nil {
		panic(err)
	}
	defer pool.Close()

	router := mux.NewRouter()

	router.HandleFunc("/category/{category}/{position}", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		vars := mux.Vars(r)
		category := vars["category"]
		position, err := strconv.ParseInt(vars["position"], 10, 64)
		if err != nil {
			panic(err)
		}
		err, msgs := getCategoryMessages(pool, category, position)
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

	// done := make(chan os.Signal, 1)
	// signal.Notify(done, os.Interrupt, syscall.SIGINT, syscall.SIGTERM)
	// <-done
	// pool.Close()
}
