import boto3
import os

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    sns = boto3.client('sns')

    source_bucket = event['Records'][0]['s3']['bucket']['name']
    source_key = event['Records'][0]['s3']['object']['key']

    destination_bucket = os.environ['OUTPUT_BUCKET']
    destination_key = f"processed/{source_key}"

    s3.copy_object(
        Bucket=destination_bucket,
        CopySource={'Bucket': source_bucket, 'Key': source_key},
        Key=destination_key
    )

    sns.publish(
        TopicArn=os.environ['SNS_TOPIC_ARN'],
        Message=f"File '{source_key}' has been processed and moved to '{destination_bucket}/{destination_key}'."
    )

    return {
        'statusCode': 200,
        'body': f"File '{source_key}' processed successfully."
    }
