# Gmail Setup Guide

## OAuth2 Configuration

1. In Google Cloud Console, enable Gmail API
2. Add OAuth scope: `https://www.googleapis.com/auth/gmail.send`
3. Add authorized redirect URI: `https://your-n8n-instance/rest/oauth2-credential/callback`
4. Create OAuth2 Client ID for web application

## n8n Credential Setup

1. In n8n, go to Credentials → New
2. Select Gmail OAuth2 API
3. Enter Client ID and Secret
4. Complete OAuth flow

## Testing Email Sending

1. Create test workflow
2. Use Gmail "Send and Wait" node
3. Send to test email address
4. Verify email received with interactive form