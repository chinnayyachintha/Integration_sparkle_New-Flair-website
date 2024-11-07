# This code retrieves the encryption key from AWS Secrets Manager, 
# then uses it to decrypt the incoming encrypted data
# (in this example, it's base64 encoded for simplicity).

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
    encrypted_data = event['body']  # Assume the body contains encrypted data
    
    # Get the encryption key from Secrets Manager
    secret_name = "encryption_key"  # Replace with your Secrets Manager key name
    encryption_key = get_secret(secret_name)
    
    # Decrypt the data (example: simple base64 decoding)
    try:
        decrypted_data = base64.b64decode(encrypted_data).decode('utf-8')
    except Exception as e:
        print(f"Decryption failed: {e}")
        return {"statusCode": 400, "body": "Decryption failed"}
    
    return {"statusCode": 200, "body": decrypted_data}
