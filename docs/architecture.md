# System Architecture

## Data Flow

### 1. Trigger Phase
- Google Drive poller checks folder every minute
- Detects new file creation events
- Extracts file metadata (ID, name, owner)

### 2. Processing Phase
- File downloaded as binary
- PDF text extraction preserves formatting
- GPT-4 evaluates using structured prompt
- Output parser enforces JSON schema

### 3. Storage Phase
- Assessment stored in n8n Data Table
- Each CV gets unique row by fileId
- Upsert operation prevents duplicates

### 4. Routing Phase
- Pass condition (score ≥ 70)
- High score → Human review track
- Low score → Auto-reject track

### 5. Human Review Phase
- Email sent with candidate data
- Custom form collects decision
- Webhook captures response
- Data table updated with human decision

## State Management

Each CV goes through states:
1. `NEW` - Detected in Drive
2. `PROCESSING` - Being evaluated by AI
3. `ASSESSED` - Scores stored in table
4a. `AUTO_REJECTED` - Failed threshold
4b. `PENDING_REVIEW` - Passed, awaiting human
5b. `HUMAN_REVIEWED` - Decision recorded

## Idempotency

- File ID used as unique key
- Upsert operations prevent reprocessing
- Email webhook tracks unique responses