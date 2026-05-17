# OpenAI Setup Guide

## Getting API Key

1. Sign up at [OpenAI Platform](https://platform.openai.com/)
2. Go to API Keys section
3. Create new secret key
4. Copy key immediately (won't be shown again)

## n8n Configuration

1. In n8n, go to Credentials → New
2. Select OpenAI API
3. Enter API key
4. Test connection

## Model Selection

- **gpt-4o-mini** (recommended): Fast, cost-effective for CV screening
- **gpt-4**: More accurate but slower and more expensive
- **gpt-3.5-turbo**: Cheapest but less reliable for complex scoring

## Cost Estimation

Average CV analysis: ~500-1000 tokens
Cost per CV with gpt-4o-mini: ~$0.001
1000 CVs per month: ~$1.00