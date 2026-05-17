# Google Drive Setup Guide

## Creating OAuth2 Credentials

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable the Google Drive API
4. Configure OAuth consent screen:
   - User Type: External
   - App name: n8n CV Screening
   - Scopes: `https://www.googleapis.com/auth/drive.readonly`
5. Create OAuth2 Client ID:
   - Application type: Web application
   - Redirect URIs: `https://your-n8n-instance/rest/oauth2-credential/callback`
6. Copy Client ID and Secret to n8n

## Setting Up the Watched Folder

1. Create folder in Google Drive
2. Share folder with appropriate team members
3. Copy folder ID from URL: `https://drive.google.com/drive/folders/[FOLDER_ID]`
4. Update folder ID in n8n Google Drive node

## Testing the Connection

1. Upload test CV to folder
2. Check n8n execution logs
3. Verify file appears in workflow