module "eventbridge" {
  depends_on = [
    aws_sns_topic.user_updates
  ]
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false

  rules = {
    macie = {
      description = "Capture macie data"
      event_pattern = jsonencode({
        "source": ["aws.macie"],
        "detail-type": ["Macie Finding"]
      })
    }
  }

  targets = {
    macie = [
      {
        name  = aws_sns_topic.user_updates.name
        arn   = aws_sns_topic.user_updates.arn
        type  = "SNS Topic"
      }
    ]
  }

  tags = {
    Name = "macie-bus"
  }
}