# Testing Rules

**Make Tests Deterministic**:

- Produce the same result on every run, machine, and execution order.

**Keep Tests Isolated**:

- Make every test pass alone and in any order.
- Build fresh state inside each test instead of depending on another test's leftovers.
- Share no mutable state across tests.

**Test Behavior, Not Implementation**:

- Assert on observable outputs and public contracts, never private internals or call order.

**Cover Edge Cases And Errors**:

- Assert that invalid input and failures raise the expected error rather than passing silently.

**One Reason To Fail**:

- Verify a single behavior so a failure points to one cause.

**Structure Setup, Act, Assert**:

- Separate setup, the one action under test, and verification.

**Weight Toward Lower Layers**:

- Test each behavior at the lowest layer that can catch its failure.
- Keep many fast low-level tests, fewer mid-level, fewest full-stack.
- Reserve full-stack tests for critical user journeys and for confirming components are wired together.

**Treat Tests As Production Code**:

- Hold tests to the same review, naming, and readability standards as shipping code
