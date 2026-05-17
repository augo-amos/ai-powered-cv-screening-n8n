# Customization Guide

## Adding New Scoring Dimensions

1. Update AI prompt in "AI CV Assessor":

New Dimension (0-100): Description


2. Update weight calculation:

Overall = (Technical*0.25 + Experience*0.20 + ... + NewDim*0.10)


3. Add column to Data Table:
- newDimensionScore (number)

4. Update Store Assessment node mapping

## Changing Pass Threshold

Option A - Update AI prompt:

A candidate PASSES if overall score >= [NEW_THRESHOLD]


Option B - Update IF node condition:
{{ $("AI CV Assessor").item.json.output.overallScore >= 75 }}


## Adding Slack Integration

Insert after "AI CV Assessor":
1. Add Slack node
2. Configure webhook
3. Map message content

```json
{
  "text": "New candidate: {{candidateName}} scored {{overallScore}}"
}