# IAM Role for Lambda with necessary policies
resource "aws_iam_role" "lambda_execution_role" {
  name               = var.lambda_role_name
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
}

# Separate IAM role policies for Lambda's permissions

# Policy for DynamoDB access
resource "aws_iam_role_policy" "dynamodb_access_policy" {
  name = "lambda_dynamodb_access_policy"
  role = aws_iam_role.lambda_execution_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["dynamodb:PutItem", "dynamodb:GetItem"]
        Effect   = "Allow"
        Resource = var.dynamodb_table_arn
      }
    ]
  })
}

# Policy for CloudWatch Logs access
resource "aws_iam_role_policy" "logs_access_policy" {
  name = "lambda_logs_access_policy"
  role = aws_iam_role.lambda_execution_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["logs:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Policy for Secrets Manager access
resource "aws_iam_role_policy" "secrets_manager_access_policy" {
  name = "lambda_secrets_manager_access_policy"
  role = aws_iam_role.lambda_execution_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["secretsmanager:GetSecretValue"]
        Effect   = "Allow"
        Resource = var.encryption_key_arn
      }
    ]
  })
}
