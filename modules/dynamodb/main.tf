# DynamoDB Table for Payment Tokens

resource "aws_dynamodb_table" "payment_tokens" {
  name           = var.dynamodb_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "token_id"

  attribute {
    name = "token_id"
    type = "S"
  }

  tags = {
    Name = var.dynamodb_table_name
  }
}

