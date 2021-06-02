package main

import (
	"embed"
	"fmt"
	"io/fs"
	"net/http"
)

//go:embed ui/dist/*
var content embed.FS

func clientHandler() http.Handler {
	fsys := fs.FS(content)
	contentStatic, _ := fs.Sub(fsys, "ui/dist")
	return http.FileServer(http.FS(contentStatic))
}

func main() {
	port := ":8080"
	mux := http.NewServeMux()
	mux.Handle("/", clientHandler())
	fmt.Printf("http://localhost%v\n", port)
	http.ListenAndServe(port, mux)
}
