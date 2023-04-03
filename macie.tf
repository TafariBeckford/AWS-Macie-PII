resource "aws_macie2_account" "PII" {
  finding_publishing_frequency = "FIFTEEN_MINUTES"
  status                       = "ENABLED"


}

resource "aws_macie2_classification_job" "JOB" {
  job_type = "ONE_TIME"
  name     = "standard test"
  s3_job_definition {
    bucket_definitions {
      account_id = data.aws_caller_identity.current.account_id
      buckets    = [module.s3_bucket.s3_bucket_id]

    }
  }
  depends_on = [
  aws_macie2_account.PII]
}

resource "aws_macie2_custom_data_identifier" "example" {
  name  = "Plates"
  regex = "([0-9][a-zA-Z][a-zA-Z]-?[0-9][a-zA-Z][a-zA-Z])|([a-zA-Z][a-zA-Z][a-zA-Z]-?[0-9][0-9][0-9])|([a-zA-Z][a-zA-Z]-?[0-9][0-9]-?[a-zA-Z][a-zA-Z])|([0-9][0-9][0-9]-?[a-zA-Z][a-zA-Z][a-zA-Z])|([0-9][0-9][0-9]-?[0-9][a-zA-Z][a-zA-Z])"

  depends_on = [
    aws_macie2_account.PII
  ]
}

resource "aws_macie2_classification_job" "custom" {
  job_type                   = "ONE_TIME"
  name                       = "custom job"
  custom_data_identifier_ids = [aws_macie2_custom_data_identifier.example.id]

  s3_job_definition {
    bucket_definitions {
      account_id = data.aws_caller_identity.current.account_id
      buckets    = [module.s3_bucket.s3_bucket_id]

    }
  }
  depends_on = [
    aws_macie2_account.PII,
  ]
}

