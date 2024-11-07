output "payment_tokens_arn" {
  value = aws_dynamodb_table.payment_tokens.arn
}

output "table_name" {
  value = aws_dynamodb_table.payment_tokens.name
}