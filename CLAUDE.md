# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup

```bash
python -m venv venv
source venv/bin/activate
pip install jupyter ipykernel anthropic python-dotenv pre-commit
pre-commit install
```

Copy `.env` with your keys (both are required for RAG notebooks; only `ANTHROPIC_API_KEY` is needed elsewhere):

```
ANTHROPIC_API_KEY=...
VOYAGE_API_KEY=...
```

Launch notebooks: `jupyter notebook` or `jupyter lab`.

## Linting and Formatting

Pre-commit runs `ruff` (lint + format) and `nbstripout` (strip notebook outputs) automatically on `git commit`. To run manually:

```bash
pre-commit run --all-files
# or directly:
ruff check . --fix && ruff format .
```

`E402` is intentionally ignored — `load_dotenv()` must precede other imports in all notebooks.

There is no test suite; notebooks are the artefacts.

## Repository Structure

Six topic directories, each containing numbered Jupyter notebooks that build on each other:

| Directory | Topic |
|---|---|
| `api/` | Core API: requests, system prompts, temperature, streaming, output control |
| `tools/` | Tool use: schemas, dispatch loops, streaming, built-in tools (text editor, web search) |
| `features/` | Extended features: extended thinking, media (PDF/images), prompt caching, code execution |
| `prompt_engineering/` | Prompting techniques and evaluation |
| `evals/` | Automated prompt evaluation |
| `rag/` | Retrieval-augmented generation: chunking, embeddings (Voyage AI), vector DB, BM25, hybrid search |

Notebooks suffixed `exercise` are incomplete stubs; those suffixed `complete` or `completed` are reference solutions. Unsuffixed notebooks are the canonical versions.

## Notebook Anatomy

Every notebook follows the same structure:

1. `%pip install` cell for dependencies
2. `load_dotenv()`, then other imports
3. `client = Anthropic()` and `model = "claude-sonnet-4-6"` at module level
4. A `chat()` (or `stream_chat()`) helper defined once and reused throughout — never inline API calls at each cell
5. `add_user_message()` / `add_assistant_message()` helpers where multi-turn state is needed

The `chat()` signature expands across notebooks to accept optional `system`, `tools`, `temperature`, `stop_sequences`, and `thinking` parameters as those topics are introduced.

## Tool-Use Pattern

Tool notebooks split responsibilities across four functions:

- **Schema** (`*_schema`): `ToolParam` dict with `name`, `description`, `input_schema`
- **Implementation**: plain Python function with matching signature
- **Dispatch** (`run_tool` / `run_tools`): maps `tool_use` blocks to implementations; wraps errors as `tool_result` blocks with `is_error: true`
- **Agentic loop** (`run_conversation`): `while True` calling `chat()`, breaking on `stop_reason != "tool_use"`

## Model Conventions

- Default model: `claude-sonnet-4-6`
- Assistant prefill notebooks use `claude-sonnet-4-0` — prefill is unsupported on `claude-sonnet-4-6` and newer. This is intentional; do not treat it as a bug.
