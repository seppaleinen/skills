---
name: cafes-workflow-audit
description: Audit AI agent workflow instructions, system prompts, AGENTS.md, CLAUDE.md, .cursorrules, and context files using the CAFE(S) Context Quality Framework. Use for prompt audits, context engineering, and workflow review.
license: MIT
compatibility: OpenCode, Claude Code, Cursor, Windsurf, Open Interpreter
allowed-tools: Read Grep
metadata:
  version: "1.0.0"
  tags: context-engineering, prompt-audit, agent-workflows, cafes-framework
---

# CAFE(S) Workflow Audit Skill

Audit AI agent workflow instructions, system prompts, runbooks, tool descriptions, and shared repository context files (e.g., `AGENTS.md`, `CLAUDE.md`, `.cursorrules`) using the **CAFE(S)** framework (Clarity, Actionability, Fidelity, Efficiency, Security).

## When to Activate

Activate this skill when the user asks to:
- Audit, review, or improve an `AGENTS.md`, `CLAUDE.md`, `.cursorrules`, system prompt, or workflow runbook
- Evaluate context quality or prompt quality with CAFE(S)
- Find context smells, prompt defects, or inefficiencies in agent instructions
- Generate diffs to optimize context files

Do not activate for unrelated tasks or general writing.

## Prerequisites

- The target context file must be readable in the workspace.
- Tools needed: `Read` (inspect files), `Grep` (find patterns). `allowed-tools: Read Grep` is pre-approved.

## Audit Workflow

When evaluating a workflow file or prompt set, follow this pipeline:

```
[Step 1: In Situ Scoping] ➔ [Step 2: CAFE(S) Scan] ➔ [Step 3: Context Smell Identification] ➔ [Step 4: Risk Matrix] ➔ [Step 5: Diff Generation]
```

### Step 1: In Situ Context Scoping
- Determine where the file lives (e.g., Global Repo `AGENTS.md`, Subfolder Runbook, Dynamic Prompt Template).
- Evaluate whether the scope matches its execution frequency.

### Step 2: Dimension-by-Dimension Review
- Check every section against the 5 CAFE(S) evaluation criteria.
- Full criteria and smell catalog: see `references/cafes-dimensions.md`. Load it before scoring.

### Step 3: Context Smell Mapping
- Identify specific lines or clauses that trigger runtime context smells (e.g., missing stopping criteria ➔ Weekend Runaway).

### Step 4: Assign Quality & Risk Scorecard
- Assign a risk tier (**Low**, **Medium**, **High**, **Critical**) to each dimension based on operational impact.

### Step 5: Deliverable Generation
- Produce a structured Markdown report followed by precise search-and-replace / diff rewrites to fix all identified defects.

## Deliverable Output Template

Always format the evaluation output using the structure below:

```markdown
# 🛡️ CAFE(S) Context Quality Audit

**Target Context File**: `[Filename / Path]`
**Context Placement**: `[Global / Module / In Situ / Dynamic Prompt]`

---

## 📊 Executive Scorecard

| Dimension | Risk Rating | Status Summary |
| :--- | :---: | :--- |
| **Clarity** | 🟡 Medium | [Brief summary] |
| **Actionability** | 🔴 High | [Brief summary] |
| **Fidelity** | 🟢 Low | [Brief summary] |
| **Efficiency** | 🟡 Medium | [Brief summary] |
| **(S) Security** | 🟢 Low | [Brief summary] |

---

## 🔍 Detailed Analysis & Context Smells

### 1. Clarity
- **Strengths**: ...
- **Context Smells Identified**:
  - `Line X`: **[Smell Name]** - [Explanation]
- **Operational Impact**: [Avoidable variation / wrong target modification]

### 2. Actionability
- **Strengths**: ...
- **Context Smells Identified**:
  - `Line Y`: **[Smell Name]** - [Explanation]
- **Operational Impact**: [Runaway loop / goal drift risk]

### 3. Fidelity
- **Strengths**: ...
- **Context Smells Identified**: ...

### 4. Efficiency
- **Strengths**: ...
- **Context Smells Identified**: ...

### 5. (S) Security
- **Strengths**: ...
- **Context Smells Identified**: ...

---

## 🛠️ Recommended Diffs & Rewrites

### Fix 1: [Issue Name / Section]
```diff
- [Original problematic instruction lines]
+ [Optimized, unambiguous, actionable, and token-lean replacement]
```

---

## 💡 In Situ Placement Guidance
[Specific recommendations on whether instructions should be moved to sub-files, inline comments, or cached context.]
```

## References

- `references/cafes-dimensions.md` — Full CAFE(S) criteria and context smell catalog (loaded on demand)