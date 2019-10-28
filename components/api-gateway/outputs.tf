output "display_invoke_url" {
  value = "${aws_api_gateway_deployment.apig_deployment.invoke_url}"
}
output "api_rest_api_id" {
  value = "${aws_api_gateway_rest_api.rest_api.id}"
}
output "api_stage_name" {
  value = "${var.api_stage_name}"
}
