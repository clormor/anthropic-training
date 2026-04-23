# Project Learnings

Corrections and lessons that apply across this project, regardless of module.

---

<!-- Entries are appended below this line by the /learn command or manually by the team. -->

### [2026-04-23] "Use X across the codebase" means run it locally, not configure it globally

**Context**: User asked to "use the post-tool-format hook across the codebase". Claude interpreted this as moving the hook to global `~/.claude/settings.json`.
**Correction**: User rejected the global change and clarified they wanted the formatter run against all existing files in the current project.
**Rule**: When asked to "use X across the codebase", default to running X on the current project's files. Do not make global config changes without explicit confirmation. Clarify scope if ambiguous.
**Applies to**: global

### [2026-04-23] Do not flag direct API content access in code reviews for this repo

**Context**: Claude flagged `message.content[0].text` as unsafe in a code review, recommending a defensive check with type guards and an explicit `ValueError`.
**Correction**: User asked to skip this class of finding in all code reviews for this repo.
**Rule**: Do not flag `message.content[0].text` or missing type guards on Anthropic API response blocks as a correctness or security issue. This is a teaching/demo codebase; defensive boilerplate obscures the learning goal.
**Applies to**: all code reviews in this repo

### [2026-04-23] Do not modify existing working scripts to accommodate a new requirement

**Context**: Claude proposed extracting shared formatting logic from `post-tool-format.sh` into a common helper so a new git pre-commit hook could reuse it.
**Correction**: User did not want `post-tool-format.sh` touched. Preferred a self-contained new script, even with some duplication.
**Rule**: When a new requirement overlaps with an existing working script, write a new self-contained implementation. Do not refactor or modify the existing script unless explicitly asked.
**Applies to**: global

### [2026-04-23] Use explicit naming for helper variants, not same name with tweaks

**Context**: Claude reviewed a streaming notebook and suggested keeping `chat()` but adding `return response` to fix a consistency issue with other helpers in the series.
**Correction**: User wanted the function renamed to `stream_chat()` instead — the distinct name signals streaming behaviour at every call site.
**Rule**: When a helper has meaningfully different behaviour (streaming vs. batch, async vs. sync, etc.), rename it explicitly rather than reusing the existing name with extra parameters or a return value. Explicit naming at the call site takes priority over surface-level naming consistency.
**Applies to**: notebook helper functions in this repo

### [2026-04-23] Check if a dependency is already available before modifying scripts to handle it

**Context**: ruff was not on PATH inside the project venv. Claude tried to edit the hook script to add a venv fallback path.
**Correction**: User had already installed ruff via brew, making the script edit unnecessary. Claude should have asked or checked system PATH first.
**Rule**: Before modifying a script to work around a missing dependency, verify whether the dependency is already available another way (system package manager, global install, etc.). Ask the user if unsure rather than immediately patching the script.
**Applies to**: global

### [2026-04-23] Do not flag single-line helpers as unnecessary when called in multiple places

**Context**: Reviewing notebook 005, Claude flagged `add_assistant_message` and `add_user_message` as one-liners that add no value over calling `messages.append()` directly.
**Correction**: Both helpers are called across multiple cells, so removing them would introduce duplication. The brevity of the implementation is irrelevant if reuse is the purpose.
**Rule**: Do not suggest removing a helper solely because its body is short. Check all call sites first; if it is used in more than one place, the abstraction is earning its keep.
**Applies to**: code reviews of notebooks in this repo

### [2026-04-23] Assistant prefill is not supported in claude-sonnet-4-6 and newer models

**Context**: Reviewing notebook 005, Claude flagged `claude-sonnet-4-0` as a deprecated regression and the comment "Newer models do not support assistant message prefill" as factually wrong.
**Correction**: Both the model choice and the comment are correct. The API returns HTTP 400 "This model does not support assistant message prefill" when a conversation ends with an assistant turn on claude-sonnet-4-6+. claude-sonnet-4-0 is used intentionally to enable the prefill demonstration.
**Rule**: Do not flag use of an older model as a bug when the notebook is explicitly demonstrating assistant prefill. Verify API behaviour before marking a comment as incorrect. Use `client.messages.create()` with a trailing assistant turn to test whether a model supports prefill before claiming it does or does not.
**Applies to**: all code reviews of notebooks in this repo
