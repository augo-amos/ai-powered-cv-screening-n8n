#!/bin/bash

# Backup n8n workflow
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/workflow_backup_$TIMESTAMP.json"

mkdir -p $BACKUP_DIR

# Export workflow using n8n API
echo "Exporting workflow..."
curl -X GET \
  -H "Authorization: Bearer $N8N_API_KEY" \
  "http://localhost:5678/api/v1/workflows" \
  > $BACKUP_FILE

echo "Backup saved to: $BACKUP_FILE"

# Keep only last 30 backups
ls -tp $BACKUP_DIR/workflow_backup_*.json | tail -n +31 | xargs -r rm

echo "Backup complete. 30 most recent backups retained."