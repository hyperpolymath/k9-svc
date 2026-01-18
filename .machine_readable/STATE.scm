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
      (tech-stack . (nickel just posix-shell asciidoc podman)))

    (current-position
      (phase . "alpha")
      (overall-completion . 75)
      (components
        (must-shim . 90)
        (pedigree-schema . 85)
        (mime-registration . 95)
        (justfile . 95)
        (leash-security . 80)
        (documentation . 75)
        (examples . 85)
        (podman-integration . 70)
        (security-handshake . 40))
      (working-features
        "Environment detection (must shim)"
        "Nickel pedigree schema with contracts"
        "MIME type definition (Linux Freedesktop)"
        "MIME type definition (macOS UTI)"
        "Magic number detection (file command)"
        "Leash security model (Kennel/Yard/Hunt)"
        "Comprehensive Just recipes"
        "Containerfile for Podman deployment"
        "Compose.yaml for development"
        "Example components (all 3 security levels)"
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
        (status . "in-progress")
        (items
          ("Leash level definitions" . done)
          ("Level detection logic" . done)
          ("Security contracts" . done)
          ("Cryptographic handshake protocol" . pending)
          ("Ed25519 signature verification" . pending)))
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
          ("deploy.k9.ncl (Hunt level)" . done))))

    (blockers-and-issues
      (critical)
      (high
        "Ed25519 signature verification not implemented"
        "Hunt-level handshake is placeholder only")
      (medium
        "Need to test on macOS"
        "Need to test on Minix")
      (low
        "Documentation could use diagrams"
        "Icon for file managers not created"))

    (critical-next-actions
      (immediate
        "Implement Ed25519 signature verification"
        "Create real Hunt-level handshake")
      (this-week
        "Test container build on CI"
        "Test MIME registration on macOS")
      (this-month
        "Register with OSS-Fuzz"
        "Create comprehensive test suite"))

    (session-history
      (snapshot "2026-01-16"
        (accomplishments
          "Initial repo structure created"
          "must shim written"
          "pedigree.ncl schema defined"
          "register.ncl MIME logic"
          "justfile with core recipes"
          "README.adoc and SPEC.adoc"))
      (snapshot "2026-01-18"
        (accomplishments
          "Moved SCM files to .machine_readable/"
          "Added PLAYBOOK.scm, AGENTIC.scm, NEUROSYM.scm"
          "Created mime/ directory with k9.xml, k9.uti.plist, k9.magic"
          "Implemented leash.ncl security model"
          "Created Containerfile and compose.yaml"
          "Added example components (hello.k9, config.k9.ncl, deploy.k9.ncl)"
          "Expanded justfile with MIME, Leash, and container recipes"
          "Overall completion: 40% -> 75%")))))

; Helper: Get overall completion
(define (get-completion)
  (assoc-ref (assoc-ref state 'current-position) 'overall-completion))
