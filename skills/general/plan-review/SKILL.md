---
name: plan-review
description: Reviews a plan before implementation.
disable-model-invocation: true
context: fork
agent: general-purpose
background: false
---

Review the plan at `$ARGUMENTS` before anyone implements it. Three checkers do the checking; you start them and merge what they find.

If no plan location was given, reply "No plan given: pass a path or URL." and stop.

## Steps

1. Start three general-purpose sub-agents in parallel, one per check file in this skill's `checks/` folder:
   - `checks/claims.md`
   - `checks/consistency.md`
   - `checks/gaps.md`

   Give each one the brief below, filled in with the plan location and the absolute path of its check file. Pass nothing else.

2. Merge the findings into one report:
   - Combine findings that describe the same problem.
   - Where one finding explains another, such as a stale claim that makes two steps contradict, link the two.
   - Order findings by their effect on the plan, largest first.
   - Keep each finding's evidence as its checker gave it.

   The report is done when every finding a checker returned appears in it, merged or on its own.

## Brief

> Read the plan at `<plan>`, then do the check described in `<check file>`.
>
> Change nothing: no file edits, commits, or messages. Judge whether the plan holds up as written, not whether a different approach would be better or how it is worded.
>
> Return each finding as:
>
> - **Plan:** the claim or step, quoted or pointed at.
> - **Problem:** what is wrong.
> - **Evidence:** file:line, doc URL, or the command you ran and its output. If you found none, write **unverified** and say what you tried.
> - **Effect:** what this means for the plan, in plain words.
>
> If the check finds nothing, return "No findings" and what you checked.
