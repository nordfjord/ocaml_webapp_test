package main

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

type Message struct {
	StreamName  string          `json:"stream_name,omitempty"`
	Position    int64           `json:"position,omitempty"`
	Time        time.Time       `json:"time"`
	Data        json.RawMessage `json:"data,omitempty"`
	MessageType string          `json:"message_type,omitempty"`
}

const query = `SELECT stream_name, position, time, data, type FROM get_category_messages($1, $2, 10)`

func getCategoryMessages(ctx context.Context, pool *pgxpool.Pool, category string, position int64) ([]Message, error) {
	rows, err := pool.Query(ctx, query, category, position)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	messages := make([]Message, 0, 10)
	for rows.Next() {
		msg := Message{}
		err = rows.Scan(&msg.StreamName, &msg.Position, &msg.Time, &msg.Data, &msg.MessageType)
		if err != nil {
			return nil, err
		}
		messages = append(messages, msg)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return messages, nil
}

func main() {
	ctx := context.Background()

	connStr := "postgresql://message_store:@127.0.0.1:5432/message_store?sslmode=disable&pool_max_conns=10"
	pool, err := pgxpool.New(ctx, connStr)
	if err != nil {
		panic(err)
	}
	defer pool.Close()

	router := http.NewServeMux()

	router.HandleFunc("/category/{category}/{position}", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		category := r.PathValue("category")
		position, err := strconv.ParseInt(r.PathValue("position"), 10, 64)
		if err != nil {
			panic(err)
		}

		msgs, err := getCategoryMessages(r.Context(), pool, category, position)
		if err != nil {
			panic(err)
		}

		w.WriteHeader(http.StatusOK)
		err = json.NewEncoder(w).Encode(msgs)

		if err != nil {
			panic(err)
		}
	})
	log.Println("Server started on port 3000")
	server := &http.Server{
		Handler: router,
		Addr:    ":3000",
	}
	log.Fatal(server.ListenAndServe())
}
