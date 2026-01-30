// {{ cookiecutter.project_name }} is a CLI tool.
package main

import (
	"context"
	"fmt"
	"os"

	"{{ cookiecutter.module_path }}/cmd"
)

func main() {
	if err := cmd.Run(context.Background(), os.Args); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
