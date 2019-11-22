# AWS Account Parameters
data "aws_caller_identity" "current" {}
data "aws_iam_account_alias" "current" {}
data "aws_region" "current" {}

variable "application_name" {
  description = "The application name"
  type        = string
}
variable "description" {
  description = "Description for the API Gateway"
  type        = string
  default     = ""
}
variable "domain" {
  description = "The service domain"
  type        = string
  default     = "domain"
}
variable "resource" {
  description = "The service resource"
  type        = string
  default     = "resource"
}
variable "lambda_function_name" {
  description = "The integration lambda function name."
  type        = string
}
variable "lambda_arn" {
  description = "The integration lambda arn."
  type        = string
}
variable "lambda_invocation_arn" {
  description = "The integration lambda invocation arn."
  type        = string
}
variable "api_stage_name" {
  description = "The API Gateway's stage name."
  type        = string
  default     = "test"
}

locals {
  account_id    = data.aws_caller_identity.current.account_id
  account_alias = data.aws_iam_account_alias.current.account_alias
  region        = data.aws_region.current.name
}
