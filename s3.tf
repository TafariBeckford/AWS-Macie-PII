module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "personal-info-bucket-876"
  acl    = "private"

  versioning = {
    enabled = false
  }

}

resource "aws_s3_object" "object" {
  bucket   = module.s3_bucket.s3_bucket_id
  for_each = fileset("Fake_PII/", "*")
  key      = each.value
  source   = "Fake_PII/${each.value}"
  etag     = filemd5("FAKE_PII/${each.value}")
}