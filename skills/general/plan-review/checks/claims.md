# Claims and feasibility

A **claim** is any fact the plan relies on: what a file or function contains, how an API, library, tool or platform behaves, which versions support what, what a command does. Steps carry claims too: a step that calls X claims that X exists and does what the step needs, and a step claims that the tools, permissions and platform at hand can carry it out.

1. List every claim, both those the plan states and those its steps imply.
2. Check each one against its source: read the code, run the command, read the current docs or search the web. Treat claims about tools and libraries as possibly stale, and check them against today's docs.

Done when every claim on the list is either confirmed or a finding. End with the number of claims you checked.
