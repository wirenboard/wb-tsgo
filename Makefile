.PHONY: all clean tsgo install

PREFIX = /usr
DEB_TARGET_ARCH ?= arm64
GO_ARCH_amd64 := amd64
GO_ARCH_arm64 := arm64
GO_ARCH_armhf := arm

GO ?= go

# tsgo is pure Go: no cgo, statically linked, cross-compiles with GOARCH
# alone. The exact typescript-go version is pinned in go.mod.
TSGO_GO_ENV := CGO_ENABLED=0 GOOS=linux GOARCH=$(GO_ARCH_$(DEB_TARGET_ARCH))
ifeq ($(DEB_TARGET_ARCH),armhf)
TSGO_GO_ENV += GOARM=6
endif

all: tsgo

clean:
	rm -f tsgo

tsgo:
	$(TSGO_GO_ENV) $(GO) build -trimpath -buildvcs=false -ldflags="-s -w" \
		-o tsgo github.com/microsoft/typescript-go/cmd/tsgo

install:
	install -Dm0755 tsgo $(DESTDIR)$(PREFIX)/bin/tsgo
