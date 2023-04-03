variable "region" {
  type    = string
  default = "us-east-1"
}

variable "email" {
  default = "tafaribeckford21@gmail.com"
}

variable "name" {
  default = "macie-topic"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
