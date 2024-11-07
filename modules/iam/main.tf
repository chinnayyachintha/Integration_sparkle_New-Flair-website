# IAM Role for Lambda with necessary policies

resource "aws_iam_role" "lambda_execution_role" {
  name = var.lambda_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  # Inline policy for DynamoDB, Secrets Manager, and logs
  inline_policy {
    name = "lambda_policies"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["dynamodb:PutItem", "dynamodb:GetItem"]
          Effect   = "Allow"
          Resource = var.dynamodb_table_arn
        },
        {
          Action   = ["logs:*"]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action   = ["secretsmanager:GetSecretValue"]
          Effect   = "Allow"
          Resource = var.encryption_key_arn
        }
      ]
    })
  }
}
