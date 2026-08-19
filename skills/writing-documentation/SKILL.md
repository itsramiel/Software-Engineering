---
name: writing-documentation
description: Provides guidelines on how to write technical documentation. Use whenever writing technical documentation, software comments, commits, PR description, plans, technical replies, etc.
---

This style guide provides editorial guidelines for writing clear and consistent technical documentation for an audience of software developers and other technical practitioners.

[Anthropomorphism](#anthropomorphism)\
[Future Features](#future-features)\
[Active Voice](#active-voice)\
[Avoid excessive claims](#avoid-excessive-claims)
[Timeless documentation](#timeless-documentation)

## Anthropomorphism

Don't attribute human qualities to software or hardware.

- Anthropomorphism is a category of figurative language, which is less precise and is often harder to understand and translate than direct language

Recommended: A Delimiter object specifies where to split a string.  
Not recommended: A Delimiter object tells the splitter where a string should be broken.

Recommended: The PC detects a new device.
Not recommended: The PC sees a new device.

## Future Features

Avoid documenting future features or products, even in innocuous ways.

## Active Voice

In general, use active voice instead of passive voice. Make clear who's performing the action.

In passive voice, it's easy to neglect to indicate who or what is performing a particular action. In this kind of construction, it's often hard for readers to figure out who's supposed to do something.

Recommended: Send a query to the service. The server sends an acknowledgment.
Not recommended: The service is queried, and an acknowledgment is sent.

**Exceptions**:
In certain cases, it's okay to use passive voice. For example, passive can be okay in the following instances:

- To emphasize an object over an action.

Recommended: The file is saved.

- To de-emphasize a subject or actor.

Recommended: Over 50 conflicts were found in the file.  
Not recommended: You created over 50 conflicts in the file.

- If your readers don't need to know who's responsible for the action.

Recommended: The database was purged in January.

## Avoid excessive claims

In documentation, don't make excessive claims. An excessive claim is an assertion in the documentation that does any of the following:

- Makes a statement about performance or cost that isn't easily verifiable with data that's available to the reader.
- Makes a statement about security that would be invalidated by a security incident.
- Makes a statement that might be interpreted as subjective or even disparaging, especially about third-party products.
- When you're assessing whether some text makes an excessive claim, take into account not just what's true today about a product's performance, cost, security, or functionality, but what might be true in the future.

Consider the following guidelines:

- When you describe products, avoid superlatives like best, simplest, fastest, never, and always. Similarly, be careful about words like ensure and guarantee and use them only when something can truly be ensured or guaranteed.
- If you make specific performance claims—how fast a product is, how much storage it requires, and so on—make sure that you reference the source of your information.
- If documentation claims that a product is secure, the documentation is invalid (and not credible) if someone succeeds in compromising the product. It's safer to suggest that a feature "helps with security" or "is designed for security" because those statements are true even if a security incident occurs.
- A statement that you make about a competitive product might be untrue if you misinterpret how the product works, or later if the other company comes out with a new release.
- The safest approach is always to write factually and objectively, limiting what you say to verifiable information that will be true over the lifespan of your documentation.

Recommended: Our product distributes datasets and computation in memory across a cluster, and therefore it can be faster for this scenario than ExampleCorporation's product. For more information, see Performance comparison.  
Not recommended: Our product is faster than ExampleCorp's product.

Recommended: Using our security product is part of an overall strategy that helps prevent account takeovers from phishing attacks.  
Not recommended: Our security product prevents account takeovers from phishing attacks.

## Timeless documentation

Timeless documentation is documentation that avoids words and phrases that anchor the documentation to a point in time or assume knowledge of prior or future products and features. In general, document the current version of a product or feature.

Timeless documentation is especially important for technical documents that might be read a long time after they are written. Words like now, new, and currently can render such documentation inaccurate, outdated, or unmeaningful. In contrast, timeless documentation focuses on how the product works right now—not on how it has changed from previous versions, and not how it might change in the future.

Recommended: These subcommands let you interact with HTTP load balancing.\
Not Recommended: These new subcommands let you interact with HTTP load balancing.

Recommended: The following command-line options aren't supported:\
Not Recommended: The following command-line options aren't currently supported:

Recommended: The emulator supports the following filters:\
Not Recommended: The emulator now supports the following filters:
