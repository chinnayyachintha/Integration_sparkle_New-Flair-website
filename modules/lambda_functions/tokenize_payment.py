# This function generates a UUID token, then stores it in DynamoDB 
# with the decrypted payment data and an initial "pending" status.

import boto3
import uuid

# Initialize AWS services
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('PaymentTokens')  # Replace with your DynamoDB table name

def lambda_handler(event, context):
    decrypted_data = event['body']  # Assume this is the decrypted payment data
    
    # Generate a unique token for this payment
    token = str(uuid.uuid4())
    
    # Store the token in DynamoDB
    try:
        table.put_item(
            Item={
                'token': token,
                'payment_data': decrypted_data,
                'status': 'pending'
            }
        )
    except Exception as e:
        print(f"Error storing token in DynamoDB: {e}")
        return {"statusCode": 500, "body": "Failed to store token"}
    
    return {"statusCode": 200, "body": token}

