## Comments

### Do's

**Unobvious Why**:

- Why — the reason behind a choice the code can't show.

**API Boundary**:

- Describe how to use it, not how it works. A consumer should be able to use it correctly from the comment alone, without reading the implementation or depending on details the contract doesn't promise.

**Keep comments adjacent and current**:

- Place each comment beside what it describes, not other modules or the wider architecture.

**Prose Clarity**:

- Use complete, dense, well-punctuated sentences a reader understands without decoding.

### Don'ts

**Don't comment the obvious**:

- Cut comments that echo the syntax, name, or signature.
- Skip line-by-line narration and trailing notes that a competent engineer could understand by reading the code or docs

**History & Planning**

- No tickets, plans, or change log.

**Don't excuse bad code with comments**:

- A comment can't redeem confusing code — rename, extract, or restructure instead.
- Reach for a comment only once the structure itself can't be made clearer.
