variable "lambda_role_name" {
  description = "The name of the Lambda execution role"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  type        = string
}

variable "encryption_key_arn" {
  description = "ARN of the encryption key in Secrets Manager"
  type        = string
}