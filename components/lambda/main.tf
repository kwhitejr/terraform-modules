resource "aws_lambda_function" "function" {
  function_name = var.function_name
  description   = var.description
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  handler       = var.path_to_handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout

  role = var.execution_role_arn

  vpc_config {
    subnet_ids         = var.vpc_subnet_ids
    security_group_ids = var.vpc_security_group_ids
  }

  environment {
    variables = var.env_vars
  }

  tags = var.tags
}
