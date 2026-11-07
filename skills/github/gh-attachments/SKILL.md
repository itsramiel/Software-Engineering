---
name: gh-attachments
description: Attaches images or videos to GitHub issues, pull requests and comments through `gh`. Use when an issue, PR or comment should include a screenshot or recording, and before concluding that gh can't upload files.
---

`gh` can upload images and videos with the `--attach` flag, starting in v2.99.0. These commands support it:

- `gh issue create`, `gh issue edit`, `gh issue comment`
- `gh pr create`, `gh pr edit`, `gh pr comment`

Run `gh <command> --help` for the details. If `--attach` isn't in the help output, the installed `gh` is older than v2.99.0 and needs an upgrade.
