# {{ cookiecutter.project_name }}

{{ cookiecutter.project_description }}

## Installation

### Using Nix

```bash
nix run github:{{ cookiecutter.github_owner }}/{{ cookiecutter.github_repo }}
```
{% if cookiecutter.use_homebrew == "yes" %}
### Using Homebrew

```bash
brew tap {{ cookiecutter.github_owner }}/tap
brew install {{ cookiecutter.project_slug }}
```
{% endif %}
### From Source

```bash
git clone https://github.com/{{ cookiecutter.github_owner }}/{{ cookiecutter.github_repo }}.git
cd {{ cookiecutter.project_slug }}
nix build
```

## Usage

```bash
# Show help
{{ cookiecutter.project_slug }} --help

# Run example command
{{ cookiecutter.project_slug }} example

# Run with verbose output
{{ cookiecutter.project_slug }} --verbose example
```

## Development

This project uses Nix for reproducible development environments.

```bash
# Enter development shell
nix develop

# Or use direnv
direnv allow

{% if cookiecutter.use_sqlc == "yes" %}# Generate code (sqlc)
just generate

{% endif %}# Run checks
just check

# Build
just build

# Run tests
just test
```

## License

{{ cookiecutter.license }}
