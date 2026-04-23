# Anthropic API Course

Notebooks following along with the [Claude with the Anthropic API](https://anthropic.skilljar.com/claude-with-the-anthropic-api) course.

## Setup

Clone the repo, then run:

```bash
python3 -m venv venv
source venv/bin/activate
pip install jupyter ipykernel anthropic
```

## API Key

Get your Anthropic API key from the [Anthropic Console](https://platform.claude.com/dashboard), then create your `.env` file:

```bash
echo "ANTHROPIC_API_KEY=your-key-here" > .env
```
