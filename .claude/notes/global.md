# Project Learnings

Corrections and lessons that apply across this project, regardless of module.

---

<!-- Entries are appended below this line by the /learn command or manually by the team. -->

### [2026-04-23] "Use X across the codebase" means run it locally, not configure it globally

**Context**: User asked to "use the post-tool-format hook across the codebase". Claude interpreted this as moving the hook to global `~/.claude/settings.json`.
**Correction**: User rejected the global change and clarified they wanted the formatter run against all existing files in the current project.
**Rule**: When asked to "use X across the codebase", default to running X on the current project's files. Do not make global config changes without explicit confirmation. Clarify scope if ambiguous.
**Applies to**: global

### [2026-04-23] Check if a dependency is already available before modifying scripts to handle it

**Context**: ruff was not on PATH inside the project venv. Claude tried to edit the hook script to add a venv fallback path.
**Correction**: User had already installed ruff via brew, making the script edit unnecessary. Claude should have asked or checked system PATH first.
**Rule**: Before modifying a script to work around a missing dependency, verify whether the dependency is already available another way (system package manager, global install, etc.). Ask the user if unsure rather than immediately patching the script.
**Applies to**: global
