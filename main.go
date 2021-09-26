package main

import (
    "log"
    "net/http"
	"time"
	"net/http/httputil"

	"github.com/gorilla/mux"

)

func Handler(w http.ResponseWriter, r *http.Request) {
	data, _ := httputil.DumpRequest(r, true)
	log.Println(string(data))
	w.Write(data)
}

func main() {
    r := mux.NewRouter()
    r.HandleFunc("/", Handler)

    srv := &http.Server{
        Handler:      r,
        Addr:         ":8080",
        WriteTimeout: 15 * time.Second,
        ReadTimeout:  15 * time.Second,
    }
	log.Println("Starting mirror server")
    log.Fatal(srv.ListenAndServe())
}