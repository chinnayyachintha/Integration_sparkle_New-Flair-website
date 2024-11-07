variable "dynamodb_table_name" {
  description = "The DynamoDB table name"
  type        = string
}

variable "encryption_key_arn" {
  description = "The ARN of the encryption key"
  type        = string
}

variable "lambda_execution_role" {
  description = "The ARN of the Lambda execution role"
  type        = string
}
