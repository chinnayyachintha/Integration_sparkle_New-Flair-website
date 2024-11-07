# AWS Region where resources will be deployed
variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resources"
}

# Name of the DynamoDB table to store payment tokens and encrypted data
variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table for storing payment tokens and encrypted data"
}

# IAM role name for Lambda function execution
variable "lambda_role_name" {
  type        = string
  description = "Name of the IAM role for Lambda execution with required permissions"
}

# Name of the encryption key in Secrets Manager
variable "encryption_key_name" {
  type        = string
  description = "Name of the encryption key stored in AWS Secrets Manager for encryption and decryption"
}
