#!/usr/bin/env bash
# Test script for cookiecutter template - runs with pre-filled values

set -e

OUTPUT_DIR=".test-output-$$"

echo "Testing cookiecutter template..."
echo "Output will be created at: $OUTPUT_DIR"

cookiecutter go-nix-cli \
  --no-input \
  -o "$OUTPUT_DIR" \
  project_name="Test CLI Tool" \
  project_slug="test-cli-tool" \
  project_description="A test CLI tool for development" \
  github_owner="testuser" \
  github_repo="test-cli-tool" \
  module_path="github.com/testuser/test-cli-tool" \
  author_name="Test User" \
  author_email="test@example.com" \
  license="MIT" \
  use_cgo="no" \
  use_homebrew="yes" \
  use_sqlc="no" \
  go_version="1.25"

echo ""
echo "✓ Template generated successfully!"
echo "Output location: $OUTPUT_DIR"
echo ""
echo "To clean up: rm -rf $OUTPUT_DIR"
echo ""
echo "Add '.test-output-*' to .gitignore to exclude test outputs from git"
