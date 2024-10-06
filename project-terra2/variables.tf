variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "eu-north-1"
}

variable "s3_bucket_name" {
    description = "bucks100"
    type        = string
}

variable "s3_output_bucket_name" {
    description = "bucks101"
    type        = string
}

variable "notification_email" {
    description = "harshnain100@gmail.com"
    type        = string
}
