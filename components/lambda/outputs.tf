output "lambda_function" {
  value = "${aws_lambda_function.function}"
}
output "lambda_function_name" {
  value = "${aws_lambda_function.function.function_name}"
}
output "lambda_function_arn" {
  value = "${aws_lambda_function.function.arn}"
}
output "lambda_function_invocation_arn" {
  value = "${aws_lambda_function.function.invoke_arn}"
}
