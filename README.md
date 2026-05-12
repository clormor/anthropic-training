# Anthropic API Training

Notebooks following along with the [Claude with the Anthropic API](https://anthropic.skilljar.com/claude-with-the-anthropic-api) course.

## Setup

Clone the repo, then run:

```bash
python3 -m venv venv
source venv/bin/activate
pip install jupyter ipykernel anthropic python-dotenv pre-commit
pre-commit install
```

## API Keys

1. Get your Anthropic API key from the [Anthropic Console](https://platform.claude.com/dashboard)
2. For the embedding exercises, create your Voyage API key from your (Voyage AI Profile page)[https://dashboard.voyageai.com/organization/api-keys]
3. Create your `.env` file:

    ```bash
    echo "ANTHROPIC_API_KEY=your-key-here" > .env
    echo "VOYAGE_API_KEY=your-voyage-api-key-here" >> .env
    ```

