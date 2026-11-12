# Gaps

A **gap** is information the plan doesn't account for that would change it. Look for:

- Existing code that already does what a step builds.
- Callers, users and tests of what the plan changes.
- Project rules and decisions: `AGENTS.md`, `CLAUDE.md`, `README.md`, `CONTEXT.md`, ADRs, and the conventions of nearby code.
- Edge cases and failure paths the steps must handle.

Done when you have searched each file, module or system the plan touches for its users and for existing code that does the same job.
