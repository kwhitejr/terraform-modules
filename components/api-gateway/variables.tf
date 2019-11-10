# AWS Account Parameters
data "aws_caller_identity" "current" {}
data "aws_iam_account_alias" "current" {}
data "aws_region" "current" {}

# GENERAL
variable "application_name" {
  description = "The application name"
  type        = string
}

# APIG
variable "description" {
  description = "Description for the API Gateway"
  type        = string
  default     = ""
}
variable "service_domain" {
  description = "The service domain."
  type        = string
}
variable "service_resource" {
  description = "The service resource."
  type        = string
}
variable "service_version" {
  description = "The service version."
  type        = string
  default     = "v1"
}
variable "methods" {
  description = "HTTP methods to be integrated with the endpoint."
  type = list(object({
    method               = string
    lambda_arn           = string
    lambda_function_name = string
    authorization_type   = string
    authorizer_id        = string
  }))
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

  lambda_function_names = toset(var.methods.*.lambda_function_name)
}
