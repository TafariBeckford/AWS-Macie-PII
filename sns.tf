resource "aws_sns_topic" "macie_topic" {
  name = var.name
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.macie_topic.arn
  protocol  = "email"
  endpoint  = var.email
}
resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.macie_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.macie_topic.arn]
  }
}

