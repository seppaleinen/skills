# Personal Skills

A collection of agent skills for AI coding agents. Install and manage them with [skills.sh](https://skills.sh).

## Installation

### Using skills.sh CLI

```bash
# Install all skills from this repo
npx skills add seppaleinen/skills

# Install a specific skill
npx skills add seppaleinen/skills --skill <skill-name>

# Install to a specific agent
npx skills add seppaleinen/skills -a claude-code
```

[Learn more about skills.sh](https://skills.sh/docs)

## Repository Structure

This repo follows the [Agent Skills Specification](https://agentskills.io) and `skills.sh` conventions.

```
skills/
├── README.md
├── LICENSE
├── .gitignore
└── skills/
    ├── skill-name-1/
    │   ├── SKILL.md          # Required: metadata + instructions
    │   ├── references/       # Optional: additional docs
    │   ├── scripts/          # Optional: executable tools
    │   └── assets/           # Optional: templates, images
    └── skill-name-2/
        └── SKILL.md
```

### Adding a new skill

1. Create a new directory under `skills/`, e.g. `skills/my-skill/`
2. Add a `SKILL.md` with the required frontmatter:

   ```markdown
   ---
   name: my-skill
   description: What this skill does and when to use it. Max 1024 chars.
   license: MIT
   ---

   # My Skill

   Instructions for the agent...
   ```
3. Commit and push. Updates are picked up automatically by `npx skills update`.

### SKILL.md Requirements

- `name`: lowercase, hyphens only, max 64 chars, matches directory name
- `description`: 1-1024 chars, describes what it does and when to use it
- Frontmatter must be valid YAML

See [agentskills.io/specification](https://agentskills.io/specification) for full details.

## Skills

- [cafes-workflow-audit](./skills/cafes-workflow-audit/) — Evaluate AI agent workflow instructions, system prompts, AGENTS.md, and context files using the CAFE(S) Context Quality Framework

## Contributing

To add or update skills, commit directly to this repo. The `npx skills` CLI will discover skills automatically from `skills/` and standard agent paths.

## License

MIT © 2026 David Eriksson
