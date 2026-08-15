# wb-tsgo

Debian packaging of **tsgo**, Microsoft's native Go implementation of the
TypeScript compiler ([typescript-go](https://github.com/microsoft/typescript-go)),
for Wiren Board controllers. The tsc-compatible CLI is installed as
`/usr/bin/tsgo`:

    wb-tsgo --version
    wb-tsgo --noEmit myscript.ts

[wb-rules](https://github.com/wirenboard/wb-rules) uses it to transpile
and type-check TypeScript rule files (`/usr/bin/tsgo` is the default
of the wb-rules `-tsgo` flag). Without this package wb-rules keeps
working and rejects `.ts` rule files with a clear error. It is not
renamed to plain `tsgo` to avoid colliding with an upstream tsgo
installation.

## Building

The exact typescript-go version is pinned in `go.mod` (the blank import
in `tools.go` keeps `go mod tidy` from dropping it). The deb build
compiles tsgo from source:

    dpkg-buildpackage -b -us -uc

or directly:

    make tsgo DEB_TARGET_ARCH=arm64   # amd64 | arm64 | armhf

tsgo is pure Go: no cgo, statically linked, cross-compiles with GOARCH
alone (GOARM=6 for armhf).

## Bumping the pinned tsgo version

    go get github.com/microsoft/typescript-go@<commit>
    go mod tidy

Then update `debian/changelog` (version scheme `7.1.0~dev.YYYYMMDD`
after the upstream `tsgo --version` and pin date) and rebuild.
