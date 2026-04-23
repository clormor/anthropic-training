# Notes Directory

This directory holds Claude's long-term memory for this project. Each file accumulates learnings, corrections, and gotchas that Claude and the team discover over time.

## Files

- **`global.md`**: Learnings that apply across the entire project.
- **`<topic>.md`**: Learnings scoped to a specific area. Create these as needed (e.g. `auth.md`, `deploy.md`, `database.md`).

## Entry Format

Each entry follows this format:

```
### YYYY-MM-DD | [brief title]

**Context**: What was happening when the correction occurred.
**Correction**: What was wrong and what the right approach is.
**Rule**: The generalised principle to follow going forward.
```

## Promotion

If the same lesson appears more than twice across notes files, promote it to the Gotchas section of the project `.claude/CLAUDE.md`. This makes it a permanent rule rather than a historical note.

## Rules

- Never delete entries. Append only.
- If a note contradicts the project CLAUDE.md or the global `~/.claude/CLAUDE.md`, flag the conflict to the team.
- Commit notes files alongside code changes so the whole team benefits.
