module {{ cookiecutter.module_path }}

go {{ cookiecutter.go_version }}

require (
	github.com/urfave/cli/v3 v3.6.2
	github.com/golangci/golangci-lint/v2 v2.8.0
)

require (
	golang.org/x/sys v0.40.0 // indirect
)

tool (
	github.com/golangci/golangci-lint/v2/cmd/golangci-lint
)
