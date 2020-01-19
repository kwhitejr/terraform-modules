# AWS Account Parameters
data "aws_caller_identity" "current" {}
data "aws_iam_account_alias" "current" {}
data "aws_region" "current" {}

variable "function_name" {
  type        = string
  description = "The lambda function name."
}
variable "description" {
  type        = string
  description = "The lambda description."
}
variable "execution_role_arn" {
  type        = string
  description = "The lambda IAM execution role"
}
variable "path_to_handler" {
  type        = string
  description = "The relative path to the lambda handler function"
  default     = "src/index.handler"
}
variable "runtime" {
  type        = string
  description = "The lambda runtime"
  default     = "nodejs10.x"
}
variable "s3_bucket" {
  type        = string
  description = "The S3 bucket where the lambdas are stored."
}
variable "s3_key" {
  type        = string
  description = "The bucket key for the lambda file(s)."
}
variable "memory_size" {
  type        = string
  description = "Lambda memory size in mb"
  default     = 128
}
variable "timeout" {
  type        = string
  description = "Lambda timeout in seconds"
  default     = 10
}
variable "vpc_subnet_ids" {
  type        = list(string)
  default     = null
  description = ""
}
variable "vpc_security_group_ids" {
  type        = list(string)
  default     = null
  description = ""
}
variable "env_vars" {
  type        = map(string)
  default     = {}
  description = "e.g. map(`node_env`,`test`)"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}
