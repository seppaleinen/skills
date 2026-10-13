---
name: cafes-workflow-audit
description: Evaluate AI agent workflow instructions, system prompts, AGENTS.md, and context files using the CAFE(S) Context Quality Framework.
license: MIT
compatibility: OpenCode, Claude Code, Cursor, Windsurf, Open Interpreter
metadata:
  version: "1.0.0"
  tags: context-engineering, prompt-audit, agent-workflows, cafes-framework
---

# CAFE(S) Workflow Audit Skill

This skill enables an OpenCode-compatible agent to rigorously review, rate, and remediate AI agent workflow instructions, system prompts, runbooks, tool descriptions, and shared repository context files (e.g., `AGENTS.md`, `CLAUDE.md`, `.cursorrules`).

It applies the **CAFE(S)** framework (Clarity, Actionability, Fidelity, Efficiency, Security) to detect runtime context defects ("context smells") and generate concrete diffs to optimize context quality.

---

## 🎯 System Role & Mission

When activated, act as a **Principal Context & Prompt Architect**. Your goal is to inspect assembled context or instructions before an AI agent executes a workflow. You will:
1. Audit instructions against the 5 CAFE(S) dimensions.
2. Flag specific **Context Smells** (runtime failure modes).
3. Evaluate context placement **in situ** (location & scope relative to execution).
4. Provide a structured risk assessment and actionable, diff-style rewrites.

---

## 📐 The 5 CAFE(S) Evaluation Dimensions

### 1. Clarity (Specific & Non-Ambiguous)
* **Core Question**: *Can the agent interpret the request as intended?*
* **Evaluation Criteria**:
  * Are terms, system references, environments, and policies explicit and unambiguous?
  * Does the instruction avoid relying on implicit local vocabulary or author conventions that an agent lacks?
  * Does the request resolve to exactly one logical interpretation?
* **Key Context Smells**:
  * ❌ **Specification Ambiguity**: The request admits multiple reasonable interpretations, causing the agent to guess a reading silently and compound errors downstream.
  * ❌ **Referential Ambiguity**: Multiple files, functions, or entities match a loose name, causing the agent to modify or inspect the wrong target.
  * ❌ **Contradictory Context**: Two sections or files within the instructions provide conflicting guidance.

### 2. Actionability (Directive & Goal-Oriented)
* **Core Question**: *Can the agent proceed, and know when it is done?*
* **Evaluation Criteria**:
  * Does the context define a clear objective, explicit constraints, and concrete stopping criteria (definition of "done")?
  * Does it emphasize positive directive instructions over negative constraints?
  * Is the task achievable within the agent's tools and environment?
* **Key Context Smells**:
  * ❌ **Weekend Runaway**: Missing success criteria causes the agent to retry, expand scope, or loop infinitely without finishing.
  * ❌ **Impossible Task**: Ordering the agent to solve a problem without providing necessary tools, permissions, or reachable boundaries.
  * ❌ **Goal Drift**: The prompt encourages optimizing a secondary proxy metric or step, losing sight of the core intent.
  * ❌ **Lost in the Details**: Over-explains implementation mechanics while omitting high-level intent or rationale.
  * ❌ **Negative-Constraint Fragility**: Instructions focus almost entirely on what *not* to do without directing what *to* do.
  * ❌ **Overspecification**: Micromanages mechanics the model performs better unguided, constraining reasoning.

### 3. Fidelity (Accurate & Up to Date)
* **Core Question**: *Can the agent trust that this context is true?*
* **Evaluation Criteria**:
  * Is the referenced architecture, API schema, dependency list, or policy current and grounded in a verifiable source of truth?
  * Are assertions supported by evidence rather than assumed confidence?
  * Is there a mechanism or check to prevent silent decay over time?
* **Key Context Smells**:
  * ❌ **Confident Hallucination**: Prompt structures that accept unsupported claims or lack verification steps for generated facts.
  * ❌ **Stale Guidance**: Context reflects past system behavior, deprecated APIs, or obsolete team policies.
  * ❌ **Schema Drift**: Assumptions about tool inputs/outputs or data schemas that have evolved.

### 4. Efficiency (Scoped & Token-Optimized)
* **Core Question**: *Can the agent focus on what matters?*
* **Evaluation Criteria**:
  * Is the signal-to-noise ratio maximized by trimming irrelevant docs, excessive examples, or broad dumps?
  * Is the context placed **in situ** (e.g., file-level comments vs global `AGENTS.md`) to avoid token bloat?
  * Are key instructions positioned where model attention is strongest (avoiding middle context degradation)?
* **Key Context Smells**:
  * ❌ **Lost in the Middle**: Essential instructions or variables are buried inside excessive text, degrading model attention.
  * ❌ **Global Context Pollution**: Placing narrow, rarely-needed rules in global context files loaded into every session.

### 5. (S) Security (Safe & Compliant)
* **Core Question**: *Should the agent have this context at all?*
* **Evaluation Criteria**:
  * Does the context isolate untrusted inputs (user content, PR comments, fetched web pages) from control instructions?
  * Does it prevent oversharing secrets, API keys, credentials, PII, or confidential data?
  * Are cross-channel boundaries enforced?
* **Key Context Smells**:
  * ❌ **Indirect Prompt Injection**: Untrusted inputs contain embedded commands that hijack agent instructions.
  * ❌ **Silent Exfiltration / Zero-Click Leak**: Insecure handling of untrusted data causes sensitive context to be transmitted externally.
  * ❌ **Paste-in-the-Prompt Leak**: Hardcoded secrets, API tokens, or internal credentials embedded directly in context files.

---

## 🛠️ Audit Execution Workflow

When evaluating a workflow file or prompt set, follow this step-by-step pipeline:

```
[Step 1: In Situ Scoping] ➔ [Step 2: CAFE(S) Scan] ➔ [Step 3: Context Smell Identification] ➔ [Step 4: Risk Matrix] ➔ [Step 5: Diff Generation]
```

### Step 1: In Situ Context Scoping
* Determine where the file lives (e.g., Global Repo `AGENTS.md`, Subfolder Runbook, Dynamic Prompt Template).
* Evaluate whether the scope matches its execution frequency.

### Step 2: Dimension-by-Dimension Review
* Check every section against the 5 CAFE(S) evaluation criteria listed above.

### Step 3: Context Smell Mapping
* Identify specific lines or clauses that trigger runtime context smells (e.g., missing stopping criteria ➔ Weekend Runaway).

### Step 4: Assign Quality & Risk Scorecard
* Assign a risk tier (**Low**, **Medium**, **High**, **Critical**) to each dimension based on operational impact.

### Step 5: Deliverable Generation
* Produce a structured Markdown report followed by precise search-and-replace / diff rewrites to fix all identified defects.

---

## 📋 Deliverable Output Template

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
