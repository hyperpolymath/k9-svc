; SPDX-License-Identifier: AGPL-3.0-or-later
; STATE.scm - K9 SVC Project State

(define state
  `((metadata
      (version . "1.0.0")
      (schema-version . "1.0.0")
      (created . "2026-01-16")
      (updated . "2026-01-18")
      (project . "k9-svc")
      (repo . "https://github.com/hyperpolymath/k9-svc"))

    (project-context
      (name . "K9 Self-Validating Components")
      (tagline . "A file format that eats its own dog food")
      (tech-stack . (nickel just posix-shell asciidoc podman openssl)))

    (current-position
      (phase . "alpha")
      (overall-completion . 90)
      (components
        (must-shim . 95)
        (pedigree-schema . 90)
        (mime-registration . 95)
        (justfile . 98)
        (leash-security . 95)
        (signing-system . 90)
        (documentation . 80)
        (examples . 90)
        (podman-integration . 85)
        (ci-pipeline . 85)
        (test-suite . 85)
        (icon . 100))
      (working-features
        "Environment detection (must shim)"
        "Nickel pedigree schema with contracts"
        "MIME type definition (Linux Freedesktop)"
        "MIME type definition (macOS UTI)"
        "Magic number detection (file command)"
        "Leash security model (Kennel/Yard/Hunt)"
        "Ed25519 signing with OpenSSL"
        "Key management (~/.config/k9/keys/)"
        "Signature verification"
        "Hunt authorization workflow"
        "Comprehensive Just recipes (35+)"
        "Containerfile for Podman deployment"
        "Compose.yaml for development"
        "Example components (all 3 security levels)"
        "GitHub Actions CI pipeline"
        "Comprehensive test suite"
        "SVG icon for file managers"
        "User-level MIME registration"
        "Dogfooding self-validation"))

    (route-to-mvp
      (milestone "Core Triad"
        (status . "complete")
        (items
          ("must shim complete" . done)
          ("pedigree.ncl schema" . done)
          ("register.ncl MIME logic" . done)
          ("justfile orchestration" . done)
          ("leash.ncl security model" . done)))
      (milestone "MIME Recognition"
        (status . "complete")
        (items
          ("Linux Freedesktop XML" . done)
          ("macOS UTI plist" . done)
          ("Magic number file" . done)
          ("mime.types entry" . done)
          ("Installation recipes" . done)))
      (milestone "Security Model"
        (status . "complete")
        (items
          ("Leash level definitions" . done)
          ("Level detection logic" . done)
          ("Security contracts" . done)
          ("Ed25519 signing (sign.sh)" . done)
          ("Key management system" . done)
          ("Signature verification" . done)
          ("Hunt authorization workflow" . done)))
      (milestone "Podman Integration"
        (status . "complete")
        (items
          ("Containerfile" . done)
          ("compose.yaml" . done)
          ("Multi-stage build" . done)
          ("Non-root user" . done)))
      (milestone "Examples"
        (status . "complete")
        (items
          ("hello.k9 (Kennel level)" . done)
          ("config.k9.ncl (Yard level)" . done)
          ("deploy.k9.ncl (Hunt level)" . done)))
      (milestone "CI/CD & Testing"
        (status . "complete")
        (items
          ("GitHub Actions CI" . done)
          ("Schema validation job" . done)
          ("Container build job" . done)
          ("Test suite (test.sh)" . done)
          ("MIME validation job" . done)))
      (milestone "Assets"
        (status . "complete")
        (items
          ("SVG icon" . done))))

    (blockers-and-issues
      (critical)
      (high)
      (medium
        "Need to test on macOS"
        "Need to test on Minix"
        "CI needs actual Nickel/Just installation URLs verified")
      (low
        "Documentation could use diagrams"
        "Could add more icon variants (dark mode, small sizes)"))

    (critical-next-actions
      (immediate
        "Run test suite locally"
        "Verify CI pipeline works")
      (this-week
        "Test MIME registration on macOS"
        "Create release workflow")
      (this-month
        "Publish to package managers"
        "Create comprehensive user guide"))

    (session-history
      (snapshot "2026-01-16"
        (accomplishments
          "Initial repo structure created"
          "must shim written"
          "pedigree.ncl schema defined"
          "register.ncl MIME logic"
          "justfile with core recipes"
          "README.adoc and SPEC.adoc"))
      (snapshot "2026-01-18-morning"
        (accomplishments
          "Moved SCM files to .machine_readable/"
          "Added PLAYBOOK.scm, AGENTIC.scm, NEUROSYM.scm"
          "Created mime/ directory with k9.xml, k9.uti.plist, k9.magic"
          "Implemented leash.ncl security model"
          "Created Containerfile and compose.yaml"
          "Added example components (hello.k9, config.k9.ncl, deploy.k9.ncl)"
          "Expanded justfile with MIME, Leash, and container recipes"
          "Overall completion: 40% -> 75%"))
      (snapshot "2026-01-18-afternoon"
        (accomplishments
          "Implemented sign.sh with Ed25519 via OpenSSL"
          "Key management in ~/.config/k9/keys/"
          "Signing, verification, and authorization workflows"
          "Created assets/k9-icon.svg"
          "Added .github/workflows/ci.yml"
          "Created comprehensive test.sh"
          "Added signing and test recipes to justfile"
          "Overall completion: 75% -> 90%"))
      (snapshot "2026-01-18-evening"
        (accomplishments
          "Fixed config.k9.ncl Nickel syntax (removed invalid _ field)"
          "Fixed test.sh key path bug (XDG_CONFIG_HOME handling)"
          "All 24 tests now pass"
          "Test suite verified: environment, schemas, examples, MIME, signing, container")))))

; Helper: Get overall completion
(define (get-completion)
  (assoc-ref (assoc-ref state 'current-position) 'overall-completion))
