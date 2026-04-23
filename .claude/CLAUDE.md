# Project: [PROJECT NAME]

This file augments the global Valliance standards in `~/.claude/CLAUDE.md`. Do not repeat global rules here. Only add project-specific conventions, stack details, and gotchas.

---

## Stack

<!-- Describe the project's tech stack so Claude knows what it is working with. -->

- **Language**: [e.g. TypeScript 5.x]
- **Runtime**: [e.g. Node 20 LTS]
- **Framework**: [e.g. Next.js 14 App Router]
- **Database**: [e.g. PostgreSQL 16 via Prisma]
- **Hosting**: [e.g. Vercel, AWS ECS, etc.]
- **Package manager**: [e.g. pnpm]

## Project Conventions

<!-- Add conventions specific to this codebase that differ from or extend the globals. -->

### File Structure

<!-- Describe the project's directory layout so Claude knows where things live. -->

### API Conventions

<!-- Describe API patterns: REST/GraphQL, auth model, response envelope, error format. -->

### Styling

<!-- Tailwind? CSS Modules? Describe the approach. -->

## Gotchas

<!-- This is the most valuable section. Update it every time Claude or a team member hits a recurring issue in THIS project. -->

- **"Use X across the codebase" means run it on project files, not configure it globally.** Do not touch `~/.claude/` or other global config without explicit confirmation.
- **Before patching a script to handle a missing dependency, check whether it is already installed another way** (brew, system PATH, etc.). Ask the user rather than assuming it needs a workaround.
- **Assistant prefill is not supported on claude-sonnet-4-6 and newer.** The API returns HTTP 400 when a conversation ends with an assistant turn on current models. Notebooks that demonstrate prefill must use an older model (e.g. claude-sonnet-4-0) intentionally. Do not flag this as a regression or the associated comment as incorrect without testing first.

## Memory Protocol

Claude maintains a long-term memory system in `.claude/notes/`. This is how the team compounds Claude's effectiveness in this codebase over time.

### How it works

- **`.claude/notes/global.md`**: Learnings that apply across the entire project.
- **`.claude/notes/<topic>.md`**: Learnings scoped to a specific area (e.g. `auth.md`, `infra.md`, `payments.md`). Created on demand.
- The Gotchas section above is the canonical ruleset for this project. Notes that appear more than twice get promoted here.

### Rules

- Never delete entries from notes files. They are a historical record.
- If a note contradicts something in this file or the global CLAUDE.md, flag the conflict to the team. Do not silently overwrite.
- Every team member can and should contribute to the notes.
