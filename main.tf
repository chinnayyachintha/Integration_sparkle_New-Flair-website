module "dynamodb" {
  source              = "./modules/dynamodb"
  dynamodb_table_name = var.dynamodb_table_name
}

module "iam" {
  source             = "./modules/iam"
  lambda_role_name   = var.lambda_role_name
  dynamodb_table_arn = module.dynamodb.payment_tokens_arn
  encryption_key_arn = module.secrets_manager.encryption_key_arn
}


module "secrets_manager" {
  source              = "./modules/secrets_manager"
  encryption_key_name = var.encryption_key_name
}

module "lambda_functions" {
  source                = "./modules/lambda"
  dynamodb_table_name   = module.dynamodb.table_name
  encryption_key_arn    = module.secrets_manager.encryption_key_arn
  lambda_execution_role = module.iam.lambda_execution_role_arn
}


module "api_gateway" {
  source = "./modules/api_gateway"
  lambda_functions = {
    decrypt  = module.lambda_functions.decrypt_lambda_arn
    tokenize = module.lambda_functions.tokenize_lambda_arn
    process  = module.lambda_functions.process_lambda_arn
    encrypt  = module.lambda_functions.encrypt_lambda_arn
  }
}
