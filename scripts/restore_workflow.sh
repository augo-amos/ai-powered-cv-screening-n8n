#!/bin/bash

# Restore workflow from backup
BACKUP_FILE=$1

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: ./restore_workflow.sh <backup_file.json>"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: File $BACKUP_FILE not found"
    exit 1
fi

echo "Restoring workflow from $BACKUP_FILE..."

# Import via n8n API
curl -X POST \
  -H "Authorization: Bearer $N8N_API_KEY" \
  -H "Content-Type: application/json" \
  -d @"$BACKUP_FILE" \
  "http://localhost:5678/api/v1/workflows/import"

echo "Restore complete. Activate workflow manually in n8n UI."