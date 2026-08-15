//go:build tools

// Package tools pins the tsgo TypeScript compiler (Microsoft's
// typescript-go) for the wb-tsgo Debian package. The blank import keeps
// the module requirement in go.mod so `go mod tidy` does not drop it;
// the package itself is never built (the "tools" build tag is never set).
//
// The deb build runs (see Makefile):
//
//	go build github.com/microsoft/typescript-go/cmd/tsgo
//
// To bump the pinned tsgo version:
//
//	go get github.com/microsoft/typescript-go@<commit> && go mod tidy
package tools

import _ "github.com/microsoft/typescript-go/cmd/tsgo"
