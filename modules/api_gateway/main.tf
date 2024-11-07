resource "aws_apigatewayv2_api" "payment_api" {
  name          = "PaymentAPI"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.payment_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "decrypt_integration" {
  api_id           = aws_apigatewayv2_api.payment_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_functions["decrypt"]
}

resource "aws_apigatewayv2_route" "decrypt_route" {
  api_id    = aws_apigatewayv2_api.payment_api.id
  route_key = "POST /decrypt"
  target    = "integrations/${aws_apigatewayv2_integration.decrypt_integration.id}"
}

# Additional integrations and routes for other endpoints
