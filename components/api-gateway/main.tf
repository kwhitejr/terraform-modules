resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "${var.application_name} API"
  description = var.description

  binary_media_types = ["*/*"]
}

resource "aws_api_gateway_resource" "domain" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = var.domain
}
resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.domain.id
  path_part   = var.resource
}
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.resource.id # aws_api_gateway_resource.version.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  depends_on = [
    aws_lambda_permission.apig_to_lambda
  ]

  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_invocation_arn}"
}

resource "aws_api_gateway_deployment" "apig_deployment" {
  depends_on = [
    aws_api_gateway_resource.proxy,
    aws_api_gateway_method.method,
    aws_api_gateway_integration.integration
  ]

  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.api_stage_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "apig_to_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*/*"
}
