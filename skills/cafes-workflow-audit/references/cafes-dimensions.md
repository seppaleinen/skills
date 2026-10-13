# CAFE(S) Dimensions — Detailed Reference

Full evaluation criteria and context smells for the CAFE(S) Context Quality Framework.

## 1. Clarity — Specific & Non-Ambiguous

**Core Question**: *Can the agent interpret the request as intended?*

**Evaluation Criteria**
- Are terms, system references, environments, and policies explicit and unambiguous?
- Does the instruction avoid relying on implicit local vocabulary or author conventions that an agent lacks?
- Does the request resolve to exactly one logical interpretation?

**Key Context Smells**
- **Specification Ambiguity**: The request admits multiple reasonable interpretations, causing the agent to guess a reading silently and compound errors downstream.
- **Referential Ambiguity**: Multiple files, functions, or entities match a loose name, causing the agent to modify or inspect the wrong target.
- **Contradictory Context**: Two sections or files within the instructions provide conflicting guidance.

## 2. Actionability — Directive & Goal-Oriented

**Core Question**: *Can the agent proceed, and know when it is done?*

**Evaluation Criteria**
- Does the context define a clear objective, explicit constraints, and concrete stopping criteria (definition of "done")?
- Does it emphasize positive directive instructions over negative constraints?
- Is the task achievable within the agent's tools and environment?

**Key Context Smells**
- **Weekend Runaway**: Missing success criteria causes the agent to retry, expand scope, or loop infinitely without finishing.
- **Impossible Task**: Ordering the agent to solve a problem without providing necessary tools, permissions, or reachable boundaries.
- **Goal Drift**: The prompt encourages optimizing a secondary proxy metric or step, losing sight of the core intent.
- **Lost in the Details**: Over-explains implementation mechanics while omitting high-level intent or rationale.
- **Negative-Constraint Fragility**: Instructions focus almost entirely on what *not* to do without directing what *to* do.
- **Overspecification**: Micromanages mechanics the model performs better unguided, constraining reasoning.

## 3. Fidelity — Accurate & Up to Date

**Core Question**: *Can the agent trust that this context is true?*

**Evaluation Criteria**
- Is the referenced architecture, API schema, dependency list, or policy current and grounded in a verifiable source of truth?
- Are assertions supported by evidence rather than assumed confidence?
- Is there a mechanism or check to prevent silent decay over time?

**Key Context Smells**
- **Confident Hallucination**: Prompt structures that accept unsupported claims or lack verification steps for generated facts.
- **Stale Guidance**: Context reflects past system behavior, deprecated APIs, or obsolete team policies.
- **Schema Drift**: Assumptions about tool inputs/outputs or data schemas that have evolved.

## 4. Efficiency — Scoped & Token-Optimized

**Core Question**: *Can the agent focus on what matters?*

**Evaluation Criteria**
- Is the signal-to-noise ratio maximized by trimming irrelevant docs, excessive examples, or broad dumps?
- Is the context placed **in situ** (e.g., file-level comments vs global `AGENTS.md`) to avoid token bloat?
- Are key instructions positioned where model attention is strongest (avoiding middle context degradation)?

**Key Context Smells**
- **Lost in the Middle**: Essential instructions or variables are buried inside excessive text, degrading model attention.
- **Global Context Pollution**: Placing narrow, rarely-needed rules in global context files loaded into every session.

## 5. (S) Security — Safe & Compliant

**Core Question**: *Should the agent have this context at all?*

**Evaluation Criteria**
- Does the context isolate untrusted inputs (user content, PR comments, fetched web pages) from control instructions?
- Does it prevent oversharing secrets, API keys, credentials, PII, or confidential data?
- Are cross-channel boundaries enforced?

**Key Context Smells**
- **Indirect Prompt Injection**: Untrusted inputs contain embedded commands that hijack agent instructions.
- **Silent Exfiltration / Zero-Click Leak**: Insecure handling of untrusted data causes sensitive context to be transmitted externally.
- **Paste-in-the-Prompt Leak**: Hardcoded secrets, API tokens, or internal credentials embedded directly in context files.

---

See `../SKILL.md` for the audit workflow and deliverable template.
