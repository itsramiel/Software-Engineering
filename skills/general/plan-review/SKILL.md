---
name: plan-review
description: Reviews a design or implementation plan.
disable-model-invocation: true
context: fork
agent: general-purpose
background: false
arguments: [altitude, plan]
argument-hint: [design|implementation] [plan]
---

Review the `$altitude` plan at `$plan` before anyone implements it. Three checkers do the checking; you start them and merge what they find.

If the altitude isn't `design` or `implementation`, reply "No altitude given: pass `design` or `implementation`." and stop.

If no plan location was given, reply "No plan given: pass a path or URL." and stop.

## Steps

1. Start three general-purpose sub-agents in parallel, one per check file in this skill's `checks/` folder:
   - `checks/claims.md`
   - `checks/consistency.md`
   - `checks/gaps.md`

   Give each one the brief below, filled in with the plan location and the absolute path of its check file. For a `design` plan, put the design paragraph where the brief marks it; for an `implementation` plan, leave that line out. Pass nothing else.

2. Merge the findings into one report:
   - Combine findings that describe the same problem.
   - Where one finding explains another, such as a stale claim that makes two steps contradict, link the two.
   - Where checkers disagree on a fact, read the evidence each one cites and keep the claim that evidence backs. If the evidence doesn't settle it, give both claims with their evidence.
   - Order findings by their effect on the plan, largest first.
   - Keep each finding's evidence as its checker gave it.

   The report holds findings only: the items checkers returned in the brief's finding format. It is done when every finding appears in it, merged or on its own.

## Brief

> Read the plan at `<plan>`, then do the check described in `<check file>`.
>
> Change nothing: no file edits, commits, or messages. Judge whether the plan holds up as written, not whether a different approach would be better or how it is worded.
>
> `<design paragraph>`
>
> Return each finding as:
>
> - **Plan:** the claim or step, quoted or pointed at.
> - **Problem:** what is wrong.
> - **Evidence:** file:line, doc URL, or the command you ran and its output. If you found none, write **unverified** and say what you tried.
> - **Effect:** what this means for the plan, in plain words.
>
> If the check finds nothing, return "No findings" and what you checked.

## Design paragraph

> The plan is a design: it settles mechanisms, contracts and behavior, and leaves the coding to an implementation pass. A finding is a **decision** the plan still needs: a mechanism that can't deliver a goal, parts that contradict, or a behavior or contract left open. Where an implementer could resolve a problem from what the plan already says, it belongs to the implementation pass. Use current code as evidence where the design relies on it staying as it is; where the plan's stated behavior changes the code, the code will differ from the plan.
>
> After **Effect:**, add a **Decision:** field to each finding: the choice the plan still has to make. If the plan already makes that choice, the problem belongs to the implementation pass.
