output "encryption_key_arn" {
  value = aws_secretsmanager_secret.encryption_key.arn
}
