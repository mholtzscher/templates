// Package cmd implements the CLI commands for {{ cookiecutter.project_name }}.
package cmd

import (
	"context"

	ufcli "github.com/urfave/cli/v3"
	"{{ cookiecutter.module_path }}/cmd/example"
	"{{ cookiecutter.module_path }}/internal/cli"
)

// Version is set at build time.
var Version = "0.1.0" // x-release-please-version

// Run is the entry point for the CLI.
func Run(ctx context.Context, args []string) error {
	app := &ufcli.Command{
		Name:    "{{ cookiecutter.project_slug }}",
		Usage:   "{{ cookiecutter.project_description }}",
		Version: Version,
		Flags: []ufcli.Flag{
			&ufcli.BoolFlag{
				Name:  cli.FlagVerbose,
				Usage: "Print verbose output",
			},
			&ufcli.BoolFlag{
				Name:  cli.FlagNoColor,
				Usage: "Disable colored output",
			},
		},
		Commands: []*ufcli.Command{
			example.NewCommand(),
		},
	}

	return app.Run(ctx, args)
}
