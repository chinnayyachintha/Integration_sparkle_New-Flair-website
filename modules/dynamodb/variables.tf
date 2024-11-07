# Name of the DynamoDB table to store payment tokens and encrypted data
variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table for storing payment tokens and encrypted data"
}
