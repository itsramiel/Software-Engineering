---
name: writing-code
description: Provides rules on how to write code in software. Use whenever writing, editing, reviewing, or planning software code.
---

# Code Rules

All code written must adhere to the following rules

## Control Flow

**Keep nesting shallow with guard clauses**:

- Each level of nesting is another condition the reader must hold in mind; prefer flat over deeply nested.
- Handle special cases and exits up front with guard clauses, leaving the nominal path unindented.
- Persistent deep nesting signals logic that should be extracted into its own function.

## Clarity Principles

**Prefer clarity over cleverness**:

- Code is read far more often than written; when several approaches work, choose the one easiest to read, even when it is harder to write.
- Distrust clever constructs: that the language permits a trick is not a reason to use it. Reach for the obvious form first.
- If you can't explain a piece of code simply, treat that as a signal to simplify it rather than to add a comment.

## Functions

**Make each function do one thing**:

- A function does one logical operation its name fully describes, at one level of abstraction. If you can't name it for what it does, its responsibilities are tangled.

## Structure & Modularity

**Build deep modules: hide complexity behind small interfaces**:

**Hide implementation behind clean boundaries**:

- Keep internal state and helper types private; expose abstractions, not internals, including in generated docs.
- Wrap third-party APIs behind an adapter so a vendor change touches one place.

## Dependencies & Coupling

**Depend on abstractions, not implementations**:

- Reference the narrowest interface that meets your need; hide what is likely to change behind a stable boundary.

**Pull complexity downward**:

- Make the implementer absorb the pain, not every caller; prefer a complex implementation over a complex interface used by many.

## Safety

**No non-null assertions**:

- Never use a non-null assertion. Always prove it

## Comments

**Describe only what the comment sits on**:

- A comment may describe only the code it sits on — what it is, does, or means. Never what's done with it, what happens to it later, or how another unit works; that belongs where that code lives.
- A value (data, event, enum, constant, parameter) has no behavior — state what each part means, not its journey through the system.

**Unobvious Why**:

- Why — the reason behind a choice the code can't show.

**API Boundary**:

- Describe how to use it, not how it works. A consumer should be able to use it correctly from the comment alone, without reading the implementation or depending on details the contract doesn't promise.

**Prose Clarity**:

- Use complete, dense, well-punctuated sentences a reader understands without decoding.

**Don't comment the obvious**:

- Cut comments that echo the syntax, name, or signature.
- Skip line-by-line narration and trailing notes that a competent engineer could understand by reading the code or docs

**Don't comment the making-of**:

- Leave out the circumstances that produced the code, such as the question that prompted it or what the author had to learn along the way, because the reader sees only the code as it stands.
- Don't describe what the code used to be or how it changed. If an old approach is a trap someone might bring back, warn against it as a rule about the code as it stands.
- Don't reference the work that produced the code: plans, specs, task lists, steps, phases. A link to a source that explains why the code is this way, such as a bug report, an upstream issue, or a discussion, is welcome.
- Judge what needs saying against the code's audience — a competent engineer in this stack — not against whoever raised the point that led to the change.
- Test: would the comment make sense to, and help, a reader who knows nothing of how the code came to be? If no, cut it.

Recommended: `// Don't batch these writes. The driver deadlocks on concurrent flushes.`
Not recommended: `// Changed from batched writes to sequential to fix a deadlock.`

Recommended: `// Works around Safari firing resize before layout settles. See #482.`
Not recommended: `// Implements step 3 of the auth migration plan (#310).`

**Don't excuse bad code with comments**:

- A comment can't redeem confusing code — rename, extract, or restructure instead.
- Reach for a comment only once the structure itself can't be made clearer.
