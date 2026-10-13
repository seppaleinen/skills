#!/usr/bin/env bash
# Scaffold a new skill in this repo
set -euo pipefail

SKILL_NAME="${1:-}"
if [[ -z "$SKILL_NAME" ]]; then
  echo "Usage: $0 <skill-name>"
  echo "  skill-name must be lowercase, hyphens only"
  exit 1
fi

# Validate name
if [[ ! "$SKILL_NAME" =~ ^[a-z0-9][a-z0-9-]*[a-z0-9]$ ]]; then
  echo "Error: skill name must be lowercase letters, numbers, and hyphens only"
  exit 1
fi

DIR="skills/$SKILL_NAME"
mkdir -p "$DIR"

cat > "$DIR/SKILL.md" <<EOF
---
name: $SKILL_NAME
description: Describe what this skill does and when to use it.
license: MIT
metadata:
  author: David Eriksson
  version: "0.1.0"
---

# $SKILL_NAME

Add your skill instructions here.

## When to Use

When should agents activate this skill?

## Instructions

Step-by-step guidance for the agent.
EOF

echo "Created $DIR/SKILL.md"
echo "Edit it, then commit:"
echo "  git add skills/$SKILL_NAME"
echo "  git commit -m 'Add $SKILL_NAME skill'"
