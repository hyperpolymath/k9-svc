; SPDX-License-Identifier: AGPL-3.0-or-later
; STATE.scm - K9 SVC Project State

(define state
  `((metadata
      (version . "1.0.0")
      (schema-version . "1.0.0")
      (created . "2026-01-16")
      (updated . "2026-01-16")
      (project . "k9-svc")
      (repo . "https://github.com/hyperpolymath/k9-svc"))

    (project-context
      (name . "K9 Self-Validating Components")
      (tagline . "A file format that eats its own dog food")
      (tech-stack . (nickel just posix-shell asciidoc)))

    (current-position
      (phase . "alpha")
      (overall-completion . 40)
      (components
        (must-shim . 90)
        (pedigree-schema . 85)
        (mime-registration . 80)
        (justfile . 75)
        (documentation . 70)
        (examples . 30)
        (podman-integration . 0)
        (security-handshake . 0))
      (working-features
        "Environment detection"
        "Nickel pedigree schema"
        "MIME XML generation"
        "Basic Just recipes"
        "User-level MIME registration"))

    (route-to-mvp
      (milestone "Core Triad"
        (status . "in-progress")
        (items
          ("must shim complete" . done)
          ("pedigree.ncl schema" . done)
          ("register.ncl MIME logic" . done)
          ("justfile orchestration" . done)))
      (milestone "MIME Recognition"
        (status . "pending")
        (items
          ("Linux Freedesktop registration" . pending)
          ("macOS UTI registration" . pending)
          ("Magic number detection" . pending)))
      (milestone "Security Model"
        (status . "pending")
        (items
          ("Implement Leash levels" . pending)
          ("Cryptographic handshake for Hunt" . pending)
          ("Contract isolation" . pending)))
      (milestone "Podman Integration"
        (status . "pending")
        (items
          ("Containerfile" . pending)
          ("podman-first deployment" . pending)
          ("Volume mapping" . pending))))

    (blockers-and-issues
      (critical)
      (high
        "Need to test Nickel schema on Minix"
        "MIME registration untested on macOS")
      (medium
        "No real-world .k9 components yet"
        "Handshake protocol not designed")
      (low
        "Documentation could use diagrams"))

    (critical-next-actions
      (immediate
        "Test must shim on current system"
        "Validate Nickel schemas")
      (this-week
        "Create Containerfile"
        "Test MIME registration")
      (this-month
        "Design handshake protocol"
        "Build example components"))

    (session-history
      (snapshot "2026-01-16"
        (accomplishments
          "Initial repo structure created"
          "must shim written"
          "pedigree.ncl schema defined"
          "register.ncl MIME logic"
          "justfile with core recipes"
          "README.adoc and SPEC.adoc")))))

; Helper: Get overall completion
(define (get-completion)
  (assoc-ref (assoc-ref state 'current-position) 'overall-completion))
