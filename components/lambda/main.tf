resource "aws_lambda_function" "function" {
  function_name = "${var.function_name}"
  description   = "${var.description}"
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.s3_key}"
  handler       = "${var.path_to_handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"

  role = "${var.execution_role_arn}"

  tags = "${var.tags}"

  environment {
    variables = "${var.env_vars}"
  }
}
