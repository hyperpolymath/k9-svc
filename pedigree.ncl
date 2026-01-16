# SPDX-License-Identifier: AGPL-3.0-or-later
# pedigree.ncl - The Alpha Breed Specification for .k9 SVC
#
# Every .k9 component inherits from this pedigree to define its
# identity, security level, and deployment contracts.

let SecurityLevel = [| 'Kennel, 'Yard, 'Hunt |] in
let Architecture = [| 'Linux, 'Minix, 'MacOS, 'Android, 'PC, 'ASIC, 'Unknown |] in

{
  # ─────────────────────────────────────────────────────────────
  # L1: The Snout - Identity
  # ─────────────────────────────────────────────────────────────
  Metadata = {
    name
      | String
      | doc "Component name (lowercase, hyphenated)",
    version
      | String
      | default = "1.0.0-alpha"
      | doc "SemVer with stability suffix",
    breed
      | String
      | default = "application/vnd.k9+nickel"
      | doc "MIME type identifier",
    magic_number
      | String
      | default = "K9!"
      | doc "Binary signature for kernel identification",
    description
      | String
      | optional
      | doc "Human-readable component purpose",
  },

  # ─────────────────────────────────────────────────────────────
  # L2: The Scent - Target Environment
  # ─────────────────────────────────────────────────────────────
  Target = {
    os
      | Architecture
      | doc "Primary deployment architecture",
    is_edge
      | Bool
      | default = false
      | doc "Constrained environment (< 1GB RAM, no Podman)",
    requires_podman
      | Bool
      | default = true
      | doc "Whether deployment needs container runtime",
    min_memory_mb
      | Number
      | default = 256
      | doc "Minimum memory requirement",
  },

  # ─────────────────────────────────────────────────────────────
  # L3: The Leash - Security Levels
  # ─────────────────────────────────────────────────────────────
  #
  # 'Kennel: Pure data. No execution. Safe to open anywhere.
  # 'Yard:   Nickel evaluation only. No I/O side effects.
  # 'Hunt:   Full triad execution. Requires handshake.
  #
  Security = {
    trust_level
      | SecurityLevel
      | default = 'Yard
      | doc "Execution permission tier",
    allow_network
      | Bool
      | default = false
      | doc "Can fetch external resources",
    allow_filesystem_write
      | Bool
      | default = false
      | doc "Can modify host filesystem",
    allow_subprocess
      | Bool
      | default = false
      | doc "Can spawn child processes",
    signature
      | String
      | optional
      | doc "Cryptographic handshake for Hunt level",
  },

  # ─────────────────────────────────────────────────────────────
  # L4: The Gut - Self-Validation (Dogfooding)
  # ─────────────────────────────────────────────────────────────
  Validation = {
    checksum
      | String
      | doc "SHA256 of component payload",
    pedigree_version
      | String
      | default = "1.0.0"
      | doc "Version of this pedigree schema",
    # Contract: Hunt requires valid signature
    hunt_authorized
      | Bool
      | default = false
      | doc "Computed: true if Hunt level is safe to execute",
  },

  # ─────────────────────────────────────────────────────────────
  # L5: The Muscle - Deployment Recipes
  # ─────────────────────────────────────────────────────────────
  Recipes = {
    install
      | String
      | default = "just install"
      | doc "Installation recipe",
    validate
      | String
      | default = "just validate"
      | doc "Self-validation recipe",
    deploy
      | String
      | default = "just deploy"
      | doc "Deployment recipe (Podman or native)",
    migrate
      | String
      | default = "just migrate"
      | doc "Version migration recipe (zero-deprecation)",
  },

  # ─────────────────────────────────────────────────────────────
  # Contract: A valid .k9 pedigree
  # ─────────────────────────────────────────────────────────────
  K9Pedigree = {
    metadata | Metadata,
    target | Target,
    security | Security,
    validation | Validation,
    recipes | Recipes,
  },
}
