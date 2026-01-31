# Go Nix CLI Template

A [Cookiecutter](https://cookiecutter.readthedocs.io/) template for Go CLI projects with Nix, gomod2nix, and full CI/CD setup.

## Features

- **Nix Flake**: Reproducible builds with gomod2nix
- **Development Environment**: direnv + devShell with Go, golangci-lint, gopls, just
- **Task Runner**: justfile with build, test, lint, format tasks
- **CI/CD**: GitHub Actions for testing and automated releases
- **Release Management**: release-please + GoReleaser
- **Homebrew**: Automatic tap publishing (optional)
- **Testing**: E2E testscript test framework
- **Documentation**: AGENTS.md template for AI coding agents

## Usage

### Using cookiecutter

```bash
# Install cookiecutter
pip install cookiecutter

# Create a new project (local path)
cookiecutter /path/to/templates/go-nix-cli

# Or from git repo (using --directory flag)
cookiecutter https://github.com/mholtzscher/templates.git --directory=go-nix-cli
```

### Using cruft (for template updates)

```bash
# Install cruft
pip install cruft

# Create a new project (local path)
cruft create /path/to/templates/go-nix-cli

# Or from git repo (using --directory flag)
cruft create https://github.com/mholtzscher/templates.git --directory=go-nix-cli

# Check for template updates
cruft check

# Update from template
cruft update
```

## Template Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `project_name` | "My CLI Tool" | Human-readable project name |
| `project_slug` | Auto-generated | Project name in kebab-case |
| `project_description` | "A Go CLI tool built with Nix" | Short description |
| `github_owner` | "username" | GitHub username or organization |
| `github_repo` | Auto-generated | GitHub repository name |
| `module_path` | Auto-generated | Go module path |
| `author_name` | "Your Name" | Author name |
| `author_email` | "your.email@example.com" | Author email |
| `license` | MIT | Project license |
| `use_cgo` | no | Enable CGO support |
| `use_homebrew` | yes | Enable Homebrew tap publishing |
| `go_version` | 1.25 | Go version |

## Post-Generation Steps

After generating your project:

1. **Initialize git**:
   ```bash
   cd your-project-name
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. **Setup Go modules**:
   ```bash
   just tidy
   ```

3. **Run checks**:
   ```bash
   just check
   ```

4. **Customize**:
   - Rename `cmd/example/` to your actual subcommand
   - Update `internal/example/` with your logic
   - Edit `AGENTS.md` with project-specific guidelines

## Project Structure

```
your-project/
├── main.go                    # Entry point
├── cmd/
│   ├── root.go               # CLI root with global flags
│   └── example/              # Example subcommand (rename me!)
│       └── example.go
├── internal/
│   ├── cli/
│   │   └── options.go        # Shared CLI options
│   └── example/              # Internal package
│       └── example.go
├── test/
│   └── testscript/           # E2E tests
│       ├── testscript_test.go
│       └── scripts/
│           └── basic.txtar
├── flake.nix                 # Nix flake
├── justfile                  # Task runner
├── .goreleaser.yaml          # Release builds
├── AGENTS.md                 # AI agent guidelines
├── README.md                 # Project readme
└── .github/
    ├── workflows/
    │   ├── ci.yml            # PR/push checks
    │   └── release-please.yml # Automated releases
    ├── release-please-config.json
    └── .release-please-manifest.json
```

## Keeping Projects Updated with Cruft

If you used `cruft` to create the project, you can easily sync with template updates:

```bash
# Check if updates are available
cruft check

# View diff of changes
cruft diff

# Update to latest template
cruft update
```

## Development Commands

All projects include a `justfile` with common tasks:

```bash
just build          # Development build
just test           # Run tests
just lint           # Run golangci-lint
just check          # Run all checks (fmt, vet, lint, test, tidy)
just update-deps    # Update Go deps and gomod2nix.toml
nix build           # Build with Nix
nix run             # Run with Nix
```

## License

MIT
