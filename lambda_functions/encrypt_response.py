# This function uses a key from Secrets Manager 
# to encrypt the response data (base64 encoding used for simplicity).

import boto3
import base64
from botocore.exceptions import ClientError

# Initialize AWS services
secrets_client = boto3.client('secretsmanager')

def get_secret(secret_name):
    try:
        secret_value = secrets_client.get_secret_value(SecretId=secret_name)
        return secret_value['SecretString']
    except ClientError as e:
        print(f"Error fetching secret: {e}")
        raise e

def lambda_handler(event, context):
    response_data = event['body']  # Assume the body contains response data to be encrypted
    
    # Get the encryption key from Secrets Manager
    secret_name = "encryption_key"  # Replace with your Secrets Manager key name
    encryption_key = get_secret(secret_name)
    
    # Encrypt the data (example: simple base64 encoding)
    try:
        encrypted_data = base64.b64encode(response_data.encode('utf-8')).decode('utf-8')
    except Exception as e:
        print(f"Encryption failed: {e}")
        return {"statusCode": 400, "body": "Encryption failed"}
    
    return {"statusCode": 200, "body": encrypted_data}
