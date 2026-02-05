#!/usr/bin/env bash
# Post-generation hook for cookiecutter

set -e

PROJECT_DIR="{{ cookiecutter.project_slug }}"

{% if cookiecutter.use_sqlc != "yes" %}
# Remove optional sqlc scaffolding when disabled
rm -f sqlc.yaml
rm -rf db
{% endif %}

echo ""
echo "=========================================="
echo "  {{ cookiecutter.project_name }} Generated!"
echo "=========================================="
echo ""
echo "Project created in: $PWD"
echo ""
echo "Next steps:"
echo ""
echo "  1. cd {{ cookiecutter.project_slug }}"
echo "  2. direnv allow          # or: nix develop"
echo "  3. just tidy             # Initialize Go modules"
{% if cookiecutter.use_sqlc == "yes" %}
echo "  4. just generate         # Generate code (sqlc)"
echo "  5. just check            # Run all checks"
{% else %}
echo "  4. just check            # Run all checks"
{% endif %}
echo ""
{% if cookiecutter.use_sqlc == "yes" %}
echo "  6. git init"
echo "  7. git add ."
echo "  8. git commit -m 'Initial commit'"
{% else %}
echo "  5. git init"
echo "  6. git add ."
echo "  7. git commit -m 'Initial commit'"
{% endif %}
echo ""
echo "Development:"
echo "  - just build             # Build the binary"
echo "  - just test              # Run tests"
echo "  - just lint              # Run linter"
echo "  - just --list            # See all commands"
echo ""
echo "See AGENTS.md for AI coding guidelines."
echo ""
