# Project: Anthropic API Training

This file augments the global Valliance standards in `~/.claude/CLAUDE.md`. Do not repeat global rules here. Only add project-specific conventions, stack details, and gotchas.

---

## Stack

- **Language**: Python 3.x
- **Runtime**: Python (virtualenv in `venv/`)
- **Framework**: Jupyter notebooks
- **Package manager**: pip
- **Key dependencies**: `anthropic`, `python-dotenv`, `jupyter`, `ipykernel`

## Project Conventions

### File Structure

```
api/                  Core API notebooks (001–005)
evals/                Evaluation notebooks
prompt_engineering/   Prompt engineering notebooks
venv/                 Local virtualenv (not committed)
```

Notebooks are numbered sequentially within each directory. Exercise and completed variants carry a suffix (`exercise`, `completed`).

### Notebook Style

- Each notebook installs its own dependencies via `%pip install` in the first cell.
- A shared `chat()` or `stream_chat()` helper is defined early in each notebook and reused across cells. Do not inline the API call at each call site.
- Helpers such as `add_user_message()` and `add_assistant_message()` are single-liners but are kept because they are called in multiple places.
- `load_dotenv()` is called before imports. `ruff` is configured to ignore E402 for this reason.
- `.env` is gitignored; the `ANTHROPIC_API_KEY` is read from it at runtime.

## Gotchas

- **"Use X across the codebase" means run it on project files, not configure it globally.** Do not touch `~/.claude/` or other global config without explicit confirmation.
- **Before patching a script to handle a missing dependency, check whether it is already installed another way** (brew, system PATH, etc.). Ask the user rather than assuming it needs a workaround.
- **Assistant prefill is not supported on claude-sonnet-4-6 and newer.** The API returns HTTP 400 when a conversation ends with an assistant turn on current models. Notebooks that demonstrate prefill must use an older model (e.g. `claude-sonnet-4-0`) intentionally. Do not flag this as a regression or the associated comment as incorrect without testing first.
- **Do not flag `message.content[0].text` as unsafe in code reviews.** This is a teaching codebase; defensive type-guard boilerplate obscures the learning goal.
- **Do not suggest removing a short helper if it is called in more than one place.** Check all call sites before recommending removal.

## Memory Protocol

Claude maintains a long-term memory system in `.claude/notes/`. This is how the team compounds Claude's effectiveness in this codebase over time.

### How it works

- **`.claude/notes/global.md`**: Learnings that apply across the entire project.
- **`.claude/notes/<topic>.md`**: Learnings scoped to a specific area. Created on demand.
- The Gotchas section above is the canonical ruleset for this project. Notes that appear more than twice get promoted here.

### Rules

- Never delete entries from notes files. They are a historical record.
- If a note contradicts something in this file or the global CLAUDE.md, flag the conflict to the team. Do not silently overwrite.
- Every team member can and should contribute to the notes.
