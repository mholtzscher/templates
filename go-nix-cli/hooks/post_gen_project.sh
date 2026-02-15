#!/usr/bin/env bash
# Post-generation hook for cookiecutter

set -e

PROJECT_DIR="{{ cookiecutter.project_slug }}"
TEMPLATE_URL="https://github.com/mholtzscher/templates.git"
TEMPLATE_DIR="go-nix-cli"

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

# Initialize cruft for template updates
if command -v cruft &>/dev/null; then
    cruft link "$TEMPLATE_URL" --directory "$TEMPLATE_DIR" --no-input 2>/dev/null || true
    if [ -f ".cruft.json" ]; then
        python3 -c "
import json
with open('.cruft.json', 'r+') as f:
    data = json.load(f)
    data['skip'] = [
        '.github/.release-please-manifest.json',
        'CHANGELOG.md',
        'README.md',
        '.goreleaser.yaml',
        'cmd',
        'internal',
        'db',
        'test',
        'sqlc.yaml',
        'main.go',
        'go.mod',
        'go.sum',
        'gomod2nix.toml',
        'flake.lock'
    ]
    f.seek(0)
    json.dump(data, f, indent=2)
    f.truncate()
"
    fi
fi
