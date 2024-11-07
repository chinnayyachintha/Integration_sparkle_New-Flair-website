output "decrypt_lambda_arn" {
  value = aws_lambda_function.decrypt_payment.arn
}

output "tokenize_lambda_arn" {
  value = aws_lambda_function.tokenize_payment.arn
}

output "process_lambda_arn" {
  value = aws_lambda_function.process_payment.arn
}

output "encrypt_lambda_arn" {
  value = aws_lambda_function.encrypt_response.arn
}
