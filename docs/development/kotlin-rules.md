# Kotlin Rules

All Kotlin code written must adhere to the following rules

## Coroutines

**Call `runBlocking` only at the outermost blocking-to-suspending boundary**:

- `runBlocking` exists to bridge code that cannot suspend into code that does: a `main` function whose framework dictates a non-`suspend` signature, an implementation of a blocking interface, a Java caller. Those boundaries are its designed use — and its only use.
- The boundary must be outermost: the thread it parks must not belong to a coroutine dispatcher, an event loop, or another `runBlocking`. A blocking bridge buried inside a library is a latent deadlock for any caller that is itself inside a coroutine.
- Prefer `suspend fun main` for entry points; fall back to `runBlocking` only when the platform or framework rules it out.
- `runBlocking` is JVM/Native bridging machinery — it does not exist on Kotlin/JS — so it can never appear in multiplatform common code.

**Never call `runBlocking` inside a coroutine or suspend function**:

- Instead of releasing the thread when the inner work suspends, it parks the thread. Dispatcher pools are finite (`Dispatchers.IO` defaults to 64 threads, shared with `Dispatchers.Default`), and every parked thread is deducted from the pool that must eventually run the work being awaited — at the limit that is deadlock, not slowness.
- Nesting `runBlocking` inside another `runBlocking` can deadlock outright: the inner call blocks the only thread the outer event loop has.
- Request handlers on coroutine-aware server frameworks (Ktor, WebFlux) already run inside a coroutine, so this rule applies there in full. Thread-per-request stacks (servlets) have no coroutine above the handler; there the boundary rule above applies instead.
- To call suspend code from suspend code, just call it; when a scope for parallel decomposition is needed, use `coroutineScope { }` — it waits without blocking.

**Don't block the Android main thread with `runBlocking`**:

- The parked thread is the one rendering frames and receiving input: the UI freezes, and the OS raises an ANR after about five seconds of unresponsiveness.
- The failure hides during development: `runBlocking`'s latency is the latency of whatever it awaits, so the call runs fast on a good network in testing and hangs in production on a bad one.
- Launch instead of block — `viewModelScope.launch` or `lifecycleScope.launch`, delivering the result through state — so the work is also cancelled with the lifecycle.
- The one defensible exception is process startup (`Application.onCreate`) when a value is genuinely required before startup may proceed and the wait is short. First try to remove the synchronous requirement; if it survives, keep the `runBlocking` and justify it with a comment.

**Wrap blocking work in `withContext(Dispatchers.IO)`, never suspending work in `runBlocking`**:

- The bridge points one way: blocking work becomes suspending by moving off-thread behind `withContext(Dispatchers.IO)`; suspending work must never be made blocking mid-stack.
- A suspend function must be safe to call from any thread, including the main thread. One that hides `runBlocking` — or bare blocking IO — breaks the contract every caller relies on, producing code that works in one call chain and deadlocks in another.
- When the blocking API honors `Thread.interrupt`, use `runInterruptible(Dispatchers.IO) { }` instead, which adds cancellation to the conversion.
- For Java callers that can consume a future, `future { }` exposes suspending work as a `CompletableFuture` without blocking any thread.

**Default tests to `runTest`; `runBlocking` in a test needs a stated reason**:

- `runTest` skips delays through virtual time and cancels hung test bodies on a built-in timeout; `runBlocking` runs every delay in real time with no control over the clock.
- Virtual time does not reach real dispatchers: pair `runTest` with injected `TestDispatcher`s, and install `Dispatchers.setMain` in local JVM tests of main-referencing code.
- The residual legitimate uses of `runBlocking` are tests that deliberately want real wall-clock time and integration tests exercising a blocking facade end-to-end; name the reason in the test.
- Never call `runBlocking` inside `runTest`: the test body is a coroutine, and the inner delays run in real time where the test scheduler cannot see them.
