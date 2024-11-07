# Secrets Manager securely stores the encryption key, and 
# Lambda can retrieve it to encrypt and decrypt sensitive data.

resource "aws_secretsmanager_secret" "encryption_key" {
  name        = var.encryption_key_name
  description = "Encryption key for payment data"
}

resource "aws_secretsmanager_secret_version" "encryption_key_value" {
  secret_id     = aws_secretsmanager_secret.encryption_key.id
  secret_string = jsonencode({ key = "your_encryption_key_here" })
}

