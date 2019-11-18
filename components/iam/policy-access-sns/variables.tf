# AWS Account Parameters
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

variable "iam_role_id" {
  description = "The IAM role that the policies shall be applied to. Reference the output of another module."
  type        = string
}
variable "sns_topic_name" {
  type        = string
  description = "The SNS topic name"
}
variable "can_publish_sns" {
  type        = bool
  default     = false
  description = "Grant access to sns topic publish"
}
variable "can_subscribe_sns" {
  type        = bool
  default     = false
  description = "Grant access to sns topic subscribe"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  sns_topic_arn = "arn:aws:sns:${local.region}:${local.account_id}:${var.sns_topic_name}"
}
