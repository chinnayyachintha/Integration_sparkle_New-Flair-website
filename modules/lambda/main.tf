resource "aws_lambda_function" "decrypt_payment" {
  function_name = "decrypt_payment"
  handler       = "decrypt_payment.handler"
  runtime       = "python3.8"
  role          = var.lambda_execution_role

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
      ENCRYPTION_KEY = var.encryption_key_arn
    }
  }
  
  # Assuming the code for Lambda functions is zipped and stored locally or in S3
  filename         = "lambda_functions/decrypt_payment.zip" # Update with actual zip path
}

resource "aws_lambda_function" "tokenize_payment" {
  function_name = "tokenize_payment"
  handler       = "tokenize_payment.handler"
  runtime       = "python3.8"
  role          = var.lambda_execution_role

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
    }
  }

  filename         = "lambda_functions/tokenize_payment.zip" # Update with actual zip path
}

resource "aws_lambda_function" "process_payment" {
  function_name = "process_payment"
  handler       = "process_payment.handler"
  runtime       = "python3.8"
  role          = var.lambda_execution_role

  filename         = "lambda_functions/process_payment.zip" # Update with actual zip path
}

resource "aws_lambda_function" "encrypt_response" {
  function_name = "encrypt_response"
  handler       = "encrypt_response.handler"
  runtime       = "python3.8"
  role          = var.lambda_execution_role

  environment {
    variables = {
      ENCRYPTION_KEY = var.encryption_key_arn
    }
  }
  
  filename         = "lambda_functions/encrypt_response.zip" # Update with actual zip path
}



