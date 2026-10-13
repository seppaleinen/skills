# CAFE(S) Workflow Audit Skill

Audit AI agent workflow instructions, system prompts, `AGENTS.md`, `CLAUDE.md`, `.cursorrules`, and context files using the **CAFE(S)** Context Quality Framework (Clarity, Actionability, Fidelity, Efficiency, Security).

See [`SKILL.md`](./SKILL.md) for the skill definition and audit workflow.

## Install

```bash
npx skills add seppaleinen/skills --skill cafes-workflow-audit
```

## Usage

Activate when asked to audit, review, or improve agent context files. The skill produces a structured Markdown report with a risk scorecard, context smell findings, and diff-style rewrites.

## Framework

CAFE(S) evaluates five dimensions:

| Dimension | Core Question |
|---|---|
| **Clarity** | Can the agent interpret the request as intended? |
| **Actionability** | Can the agent proceed, and know when it is done? |
| **Fidelity** | Can the agent trust that this context is true? |
| **Efficiency** | Can the agent focus on what matters? |
| **(S) Security** | Should the agent have this context at all? |

## License

MIT