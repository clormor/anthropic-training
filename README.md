# Anthropic API Training

Notebooks following along with the [Claude with the Anthropic API](https://anthropic.skilljar.com/claude-with-the-anthropic-api) course.

## Structure

```
api/                  Core API concepts
  001_requests        Stateless API, chat() helper, multi-turn conversations
  001_requests exercise  Exercise version of the above
  002_system_prompt   System prompts
  003_temperature     The temperature parameter
  004_streaming       Streaming responses with stream_chat()
  005_controlling_output  Output control via assistant prefill (claude-sonnet-4-0)

evals/                Evaluation
  001_prompt_evals    Building prompt evaluation datasets and scoring prompts

prompt_engineering/   Prompt engineering
  001_prompting       Prompting techniques with an evaluation framework
  002_prompting_completed  Completed reference version
```

## Setup

Clone the repo, then run:

```bash
python3 -m venv venv
source venv/bin/activate
pip install jupyter ipykernel anthropic python-dotenv pre-commit
pre-commit install
```

## API Key

Get your Anthropic API key from the [Anthropic Console](https://platform.claude.com/dashboard), then create your `.env` file:

```bash
echo "ANTHROPIC_API_KEY=your-key-here" > .env
```
