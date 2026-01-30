#!/usr/bin/env bash
# Post-generation hook for cookiecutter

set -e

PROJECT_DIR="{{ cookiecutter.project_slug }}"

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
echo "  4. just check            # Run all checks"
echo ""
echo "  5. git init"
echo "  6. git add ."
echo "  7. git commit -m 'Initial commit'"
echo ""
echo "Development:"
echo "  - just build             # Build the binary"
echo "  - just test              # Run tests"
echo "  - just lint              # Run linter"
echo "  - just --list            # See all commands"
echo ""
echo "See AGENTS.md for AI coding guidelines."
echo ""
