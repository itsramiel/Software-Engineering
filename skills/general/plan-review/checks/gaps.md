# Gaps

A **gap** is a fact the plan misses that breaks a step, leaves a goal undelivered, conflicts with a project rule or decision, or makes a step build something that already exists. Costs, risks and trade-offs the plan doesn't mention are not gaps. Look for:

- Existing code that already does what a step builds.
- Callers, users and tests of what the plan changes.
- Project rules and decisions: `AGENTS.md`, `CLAUDE.md`, `README.md`, `CONTEXT.md`, ADRs, and the conventions of nearby code.
- Edge cases and failure paths that break a step or a goal.

Done when you have searched each file, module or system the plan touches for its users and for existing code that does the same job.
