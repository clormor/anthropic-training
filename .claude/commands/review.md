# Code Review

Review the current branch's changes against main and provide structured feedback.

## Steps

1. Run `git diff main...HEAD` to see all changes on this branch.
2. Run `git log main..HEAD --oneline` to understand the commit history.
3. For each changed file, use a subagent to perform a focused review.
4. Collect all findings and present a structured report.

## Review Checklist

For each changed file, assess:

- **Correctness**: Does the logic do what the commit messages claim? Are there edge cases?
- **Security**: Any hardcoded secrets, SQL injection vectors, XSS risks, or unvalidated input?
- **Performance**: N+1 queries, unnecessary re-renders, missing indexes, unbounded loops?
- **Testing**: Are there tests for the new behaviour? Are existing tests still valid?
- **Style**: Does it follow the conventions in CLAUDE.md?
- **Naming**: Are variables, functions, and files named clearly and consistently?
- **Error handling**: Are errors caught and handled with actionable messages?

## Output Format

Group findings by severity:

- **Blocking**: Must fix before merge.
- **Should fix**: Strong recommendation, but not a blocker.
- **Nit**: Style or preference. Take it or leave it.

End with a one-line summary: "Approve", "Approve with comments", or "Request changes".
