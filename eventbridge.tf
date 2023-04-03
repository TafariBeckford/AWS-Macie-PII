resource "aws_cloudwatch_event_rule" "macie_rule" {
  name                = "macie-rule"
  event_pattern = jsonencode({
  "source": ["aws.macie"],
  "detail-type": ["Macie Finding"]
})
}

resource "aws_cloudwatch_event_target" "sns_target" {
  rule      = aws_cloudwatch_event_rule.macie_rule.name
  arn       = aws_sns_topic.macie_topic.arn
  target_id = "macie-sns"
}

