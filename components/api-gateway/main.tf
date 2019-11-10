resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "${var.application_name} API"
  description = var.description
}

resource "aws_api_gateway_resource" "domain" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = var.service_domain
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.domain.id
  path_part   = var.service_resource
}

resource "aws_api_gateway_resource" "version" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.resource.id
  path_part   = var.service_version
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.version.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method" {
  for_each = {
    for m in var.methods : "${m.method}" => m
  }

  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = each.value.method
  authorization = each.value.authorization_type
  authorizer_id = each.value.authorizer_id
}

resource "aws_api_gateway_integration" "integration" {
  for_each = {
    for m in var.methods : "${m.method}" => m
  }

  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.method[each.value.method].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${local.region}:lambda:path/2015-03-31/functions/${each.value.lambda_arn}/invocations"
}

resource "aws_api_gateway_deployment" "apig_deployment" {
  depends_on = [
    "aws_api_gateway_resource.domain",
    "aws_api_gateway_resource.resource",
    "aws_api_gateway_resource.version",
    "aws_api_gateway_resource.proxy",
    "aws_api_gateway_method.method",
    "aws_api_gateway_integration.integration"
  ]

  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.api_stage_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "apig_to_diagnostics_lambda" {
  for_each = local.lambda_function_names

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = each.value
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${local.region}:${local.account_id}:${aws_api_gateway_rest_api.rest_api.id}/*/*/*" # TODO: lock this down
}
