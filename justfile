# SPDX-License-Identifier: AGPL-3.0-or-later
# justfile - K9 SVC Orchestration (The Muscle)
#
# Part of the must-just-nickel triad.
# Usage: ./must run <recipe> OR just <recipe>

set shell := ["sh", "-eu", "-c"]
set dotenv-load

# Default recipe: show status
default:
    @./must status

# ─────────────────────────────────────────────────────────────
# Environment & Setup
# ─────────────────────────────────────────────────────────────

# Ensure the triad is installed
ensure:
    @./must ensure

# Show K9 environment report
status:
    @./must status

# ─────────────────────────────────────────────────────────────
# MIME Registration
# ─────────────────────────────────────────────────────────────

# Register .k9 MIME type (user-level)
register-user:
    @echo "K9: Registering MIME type for current user..."
    @mkdir -p ~/.local/share/mime/packages
    @nickel export register.ncl --field mime_xml > ~/.local/share/mime/packages/k9.xml
    @update-mime-database ~/.local/share/mime 2>/dev/null || true
    @echo "K9: User MIME registration complete."

# Register .k9 MIME type (system-wide, requires sudo)
register-system:
    @echo "K9: Registering MIME type system-wide..."
    @nickel export register.ncl --field mime_xml | sudo tee /usr/share/mime/packages/k9.xml > /dev/null
    @sudo update-mime-database /usr/share/mime
    @echo "K9: System MIME registration complete."

# Verify MIME registration
verify-mime:
    @echo "K9: Verifying MIME registration..."
    @echo "K9!" > /tmp/test.k9
    @file --mime-type /tmp/test.k9 || echo "MIME not registered"
    @rm -f /tmp/test.k9

# ─────────────────────────────────────────────────────────────
# Validation (The Brain)
# ─────────────────────────────────────────────────────────────

# Validate the pedigree schema
validate-pedigree:
    @echo "K9: Validating pedigree.ncl..."
    @nickel typecheck pedigree.ncl
    @echo "K9: Pedigree schema valid."

# Validate a .k9 component against the pedigree
validate file:
    @echo "K9: Validating {{file}} against pedigree..."
    @nickel typecheck {{file}}
    @echo "K9: {{file}} passes validation."

# Full validation suite
validate-all:
    @echo "K9: Running full validation suite..."
    @nickel typecheck pedigree.ncl
    @nickel typecheck register.ncl
    @echo "K9: All schemas valid."

# ─────────────────────────────────────────────────────────────
# Build & Deploy
# ─────────────────────────────────────────────────────────────

# Build documentation
docs:
    @echo "K9: Generating documentation..."
    @if command -v asciidoctor >/dev/null 2>&1; then \
        asciidoctor -o docs/README.html README.adoc 2>/dev/null || true; \
        asciidoctor -o docs/SPEC.html SPEC.adoc 2>/dev/null || true; \
        echo "K9: HTML docs generated in docs/"; \
    else \
        echo "K9: asciidoctor not found, skipping HTML generation"; \
    fi

# Deploy via Podman (if available)
deploy-podman:
    @if [ "$K9_HAS_PODMAN" = "true" ] || command -v podman >/dev/null 2>&1; then \
        echo "K9: Building Podman container..."; \
        podman build -t k9-svc:latest .; \
    else \
        echo "K9: Podman not available. Use 'just deploy-native' instead."; \
        exit 1; \
    fi

# Deploy natively (no container)
deploy-native:
    @echo "K9: Native deployment..."
    @./must ensure
    @just validate-all
    @just register-user
    @echo "K9: Native deployment complete."

# Auto-select deployment method
deploy:
    @if command -v podman >/dev/null 2>&1; then \
        just deploy-podman; \
    else \
        just deploy-native; \
    fi

# ─────────────────────────────────────────────────────────────
# Development
# ─────────────────────────────────────────────────────────────

# Format Nickel files
fmt:
    @echo "K9: Formatting Nickel files..."
    @nickel format pedigree.ncl
    @nickel format register.ncl
    @echo "K9: Formatting complete."

# Interactive Nickel REPL with pedigree loaded
repl:
    @nickel repl --import pedigree.ncl

# Export pedigree schema as JSON (for tooling)
export-schema:
    @nickel export pedigree.ncl --format json

# ─────────────────────────────────────────────────────────────
# Dogfooding
# ─────────────────────────────────────────────────────────────

# The ultimate test: use K9 to validate K9
dogfood:
    @echo "K9: Dogfooding - validating ourselves..."
    @./must ensure
    @just validate-all
    @just verify-mime || true
    @echo "K9: Dogfooding complete. We eat what we cook."
