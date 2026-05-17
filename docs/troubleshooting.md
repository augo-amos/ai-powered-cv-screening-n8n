# Troubleshooting Guide

## Workflow Not Triggering

**Symptoms**: New CVs don't start workflow

**Solutions**:
1. Verify workflow is ACTIVE (toggle switch)
2. Check Google Drive folder ID is correct
3. Confirm OAuth token hasn't expired
4. Review n8n logs for errors

## PDF Extraction Failing

**Symptoms**: "Failed to extract text" error

**Solutions**:
1. Ensure file is text-based PDF (not scanned image)
2. For scanned PDFs, add OCR node before extraction
3. Check file size limits (n8n default: 50MB)

## GPT-4 Not Returning Scores

**Symptoms**: Missing scores or malformed output

**Solutions**:
1. Verify API key has GPT-4 access
2. Check prompt length (not exceeding token limit)
3. Lower temperature for more consistent output
4. Review structured output schema

## Email Not Sending

**Symptoms**: No review email received

**Solutions**:
1. Check recipient email address
2. Verify Gmail OAuth is valid
3. Check spam folder
4. Test with simple email node first

## Data Table Issues

**Symptoms**: Upsert failing or data not saving

**Solutions**:
1. Verify table ID exists
2. Check column schema matches
3. Ensure fileId is unique
4. Review data type conversions