variable "iam_role_id" {
  description = "The IAM role that the policies shall be applied to. Reference the output of another module."
  type        = string
}
variable "table_name" {
  type        = string
  description = "The DynamoDB table name"
}
variable "can_read_table" {
  type        = bool
  default     = false
  description = "Grant access to table reads"
}
variable "can_write_table" {
  type        = bool
  default     = false
  description = "Grant access to table writes"
}
variable "can_read_table_stream" {
  type        = bool
  default     = false
  description = "Grant access to table stream reads"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}
