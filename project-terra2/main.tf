provider "aws" {
    region = var.aws_region
}

resource "aws_s3_bucket" "input_bucket" {
    bucket = var.s3_bucket_name
}

resource "aws_lambda_function" "file_processor" {
    filename         = "${path.module}/lambda_function/lambdacode.zip"
    function_name    = "file_processor_lambda"
    role             = aws_iam_role.lambda_exec.arn
    handler          = "lambda_code.lambda_handler"
    runtime          = "python3.9"
    source_code_hash = filebase64sha256("${path.module}/lambda_function/lambdacode.zip")

    environment {
    variables = {
        OUTPUT_BUCKET = var.s3_output_bucket_name
    }
    }


    depends_on = [aws_s3_bucket.input_bucket, aws_s3_bucket.output_bucket]
}


resource "aws_iam_role" "lambda_exec" {
    name = "lambda_exec_role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
            Service = "lambda.amazonaws.com"
        }
        }
    ]
    })
}

resource "aws_iam_role_policy" "lambda_policy" {
    role = aws_iam_role.lambda_exec.id
    policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Action = [
            "s3:GetObject",
            "s3:PutObject"
        ],
        Effect   = "Allow",
        Resource = [
            "${aws_s3_bucket.input_bucket.arn}/*",
            "${aws_s3_bucket.output_bucket.arn}/*"
        ]
        },
        {
        Action   = "logs:CreateLogGroup",
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
        },
        {
        Action   = "logs:CreateLogStream",
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:log-group:/aws/lambda/*"
        },
        {
        Action   = "logs:PutLogEvents",
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:log-group:/aws/lambda/*:log-stream:*"
        }
    ]
    })
}
resource "aws_s3_bucket" "output_bucket" {
    bucket = var.s3_output_bucket_name
}

# resource "aws_s3_bucket_notification" "bucket_notification" {
#     bucket = aws_s3_bucket.input_bucket.id

#     lambda_function {
#     lambda_function_arn = aws_lambda_function.file_processor.arn
#     events = ["s3:ObjectCreated:*"]
#     }
# }

resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = "bucks100"

    lambda_function {
    lambda_function_arn = aws_lambda_function.file_processor.arn
    events              = ["s3:ObjectCreated:*"]
    }

    depends_on = [
    aws_lambda_permission.allow_s3,
    aws_lambda_function.file_processor
    ]
}

resource "aws_sns_topic" "lambda_sns" {
    name = "lambda_processing_complete"
}

resource "aws_sns_topic_subscription" "email_subscription" {
    topic_arn = aws_sns_topic.lambda_sns.arn
    protocol = "email"
    endpoint = var.notification_email
}

resource "aws_lambda_permission" "allow_s3" {
    statement_id = "AllowS3Invoke"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.file_processor.function_name
    principal = "s3.amazonaws.com"
    source_arn = aws_s3_bucket.input_bucket.arn
}

resource "aws_lambda_permission" "allow_sns" {
    statement_id = "AllowSNSInvoke"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.file_processor.function_name
    principal = "sns.amazonaws.com"
}
