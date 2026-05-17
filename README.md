# AI-Powered CV Screening Workflow

An automated CV screening system built with n8n that uses GPT-4 to evaluate candidates, score their qualifications, and manage the hiring pipeline through Google Drive and Gmail.

---

## Workflow Preview

![AI-Powered CV Screening Workflow](<img width="1858" height="826" alt="image" src="https://github.com/user-attachments/assets/cae3e07a-e307-41ec-b40b-8548e428cc15" />
)

---

## Overview

This workflow automatically monitors a Google Drive folder for new CV uploads, extracts text from PDF files, uses GPT-4 to evaluate candidates across multiple dimensions, stores results in a data table, and routes high-scoring candidates for human review via email.

### Key Features

- **Automated CV Monitoring**: Watches a Google Drive folder for new uploads
- **AI-Powered Evaluation**: Uses GPT-4 to assess candidates on 6 key dimensions
- **Structured Scoring**: Weighted scoring system (0-100) with configurable pass threshold (70)
- **Data Persistence**: Stores all assessments in an n8n data table
- **Human-in-the-Loop**: High-scoring candidates trigger email review workflow
- **Auto-Rejection**: Low-scoring candidates are automatically filtered out
- **Audit Trail**: Tracks both AI and human decisions with timestamps

---

## Evaluation Criteria

| Dimension | Weight | Description |
|-----------|--------|-------------|
| Technical Skills | 30% | Depth/breadth of technical expertise |
| Experience | 25% | Years, progression, impact of roles |
| Education | 15% | Academic credentials, certifications |
| Cultural Fit | 15% | Teamwork, leadership, adaptability |
| Communication | 10% | CV clarity, grammar, presentation |
| Career Progression | 5% | Growth trajectory, increasing responsibility |

**Pass Threshold**: Overall score ≥ 70/100

---

## Prerequisites

- n8n instance (self-hosted or cloud)
- Google Drive account with API access
- Gmail account for email notifications
- OpenAI API key with GPT-4 access

---

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/augo-amos/ai-cv-screening-n8n.git
cd ai-cv-screening-n8n
```

### 2. Set Up Environment Variables

```bash
cp .env.example .env
# Edit .env with your actual credentials
```

### 3. Configure Credentials in n8n

Import the workflow and set up these credentials:

| Credential Name | Type | Required For |
|----------------|------|--------------|
| Google Drive OAuth2 API | OAuth2 | Reading CV files |
| Gmail OAuth2 API | OAuth2 | Sending review emails |
| OpenAI API | API Key | GPT-4 evaluation |

### 4. Import the Workflow

1. Open your n8n instance
2. Navigate to **Workflows** → **Import from File**
3. Upload `workflow.json`
4. Activate the workflow

### 5. Configure Google Drive Folder

Create a folder in Google Drive and share its ID:

1. Open Google Drive
2. Create a folder named `CV-Screening`
3. Get the folder ID from the URL:

```text
https://drive.google.com/drive/folders/[FOLDER_ID]
```

4. Update the `folderToWatch` parameter in the **New CV Uploaded** node

---

## Workflow Steps

```text
1. Google Drive Trigger
   ↓ (detects new PDF in watched folder)

2. Download CV
   ↓ (downloads file from Drive)

3. Extract CV Text
   ↓ (extracts text from PDF)

4. AI CV Assessor (GPT-4)
   ↓ (evaluates candidate with structured output)

5. Store Assessment
   ↓ (saves scores to Data Table)

6. Did Candidate Pass?
   ├─ YES → Send Approval Email → Human Review → Update Status
   └─ NO  → Auto-Reject → Log Rejection
```

---

## Data Table Schema

The workflow stores assessments in a table with these columns:

| Column | Type | Description |
|--------|------|-------------|
| candidateName | string | Name from CV file |
| fileId | string | Google Drive file ID |
| overallScore | number | Weighted total (0-100) |
| passed | boolean | Passed threshold? |
| technicalSkills | number | Technical score |
| experience | number | Experience score |
| education | number | Education score |
| culturalFit | number | Cultural fit score |
| communicationQuality | number | Communication score |
| careerProgression | number | Career progression score |
| summary | string | AI-generated summary |
| strengths | string | Comma-separated strengths |
| concerns | string | Comma-separated concerns |
| recommendation | string | AI recommendation |
| assessmentDate | timestamp | When assessment occurred |
| humanReviewStatus | string | Pending/Approved/Rejected |

---

## Email Review Process

When a candidate passes AI screening, an email is sent with:

- Candidate name and overall score
- AI-generated summary
- Listed strengths and concerns
- Link to view the CV
- Interactive form for reviewer decision

### Review Options

- **Approve** — Proceed to next stage
- **Reject** — Not a good fit
- **Request More Information** — Need additional details

---

## Customization

### Adjust Scoring Weights

Edit the AI prompt in the **AI CV Assessor** node:

```text
Calculate an overall score (weighted average:
Technical 30%, Experience 25%, Education 15%,
Cultural Fit 15%, Communication 10%, Career Progression 5%)
```

### Change Pass Threshold

Modify the **Did Candidate Pass?** node condition:

```javascript
{{ $("AI CV Assessor").item.json.output.passed }}
```

Or change the threshold in the AI prompt from `70` to your desired value.

### Add More Evaluation Criteria

Update the prompt in the **AI CV Assessor** node and add corresponding columns to the data table.

---

## Security Considerations

1. **API Keys**: Never commit `.env` file to version control
2. **Access Control**: Limit Google Drive folder access to authorized users
3. **Data Retention**: CVs contain PII; implement auto-deletion policies
4. **Audit Logs**: All decisions are timestamped and stored
5. **Email Privacy**: Review emails contain sensitive candidate information

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Google Drive trigger not firing | Verify folder ID and OAuth permissions |
| PDF text extraction failing | Ensure file is text-based PDF (not scanned image) |
| GPT-4 not responding | Check API key and rate limits |
| Email not sending | Verify Gmail OAuth and recipient address |
| Data table upsert failing | Check that fileId exists in table |

### Debug Mode

Enable n8n's debug mode by setting:

```env
N8N_DEBUG=true
N8N_METRICS=true
```

---

## Monitoring & Analytics

Run queries on the data table to track:

- Pass rate over time
- Average scores by dimension
- Common strengths/concerns patterns
- Human vs AI approval alignment

---

## Backup & Restore

Use included scripts:

```bash
# Backup workflow
./scripts/backup_workflow.sh

# Restore from backup
./scripts/restore_workflow.sh workflow_backup.json
```

---

## Architecture

```text
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Google    │───▶│    n8n      │───▶│   OpenAI    │
│   Drive     │    │   Trigger   │    │   GPT-4     │
└─────────────┘    └─────────────┘    └─────────────┘
                                              │
                                              ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Gmail     │◀───│    n8n      │◀───│   Data      │
│   Review    │    │   Router    │    │   Table     │
└─────────────┘    └─────────────┘    └─────────────┘
```

---

## License

MIT License — See `LICENSE` file.

---

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

---

## Support

- Open an issue on GitHub
- n8n Documentation: https://docs.n8n.io
- OpenAI API Docs: https://platform.openai.com/docs

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-05-18 | Initial release |

---

## Acknowledgments

- n8n for the automation platform
- OpenAI for GPT-4 API
- Google for Drive and Gmail APIs
