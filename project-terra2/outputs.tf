output "input_bucket_name" {
    value = aws_s3_bucket.input_bucket.bucket
}

output "output_bucket_name" {
    value = aws_s3_bucket.output_bucket.bucket
}

output "sns_topic_arn" {
    value = aws_sns_topic.lambda_sns.arn
}

output "lambda_function_name" {
    value = aws_lambda_function.file_processor.function_name
}
