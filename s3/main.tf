provider "aws" {
    region = "eu-north-1"
}

resource "aws_kms_key" "s3_kms_key" {
    description             = "KMS key for S3 bucket encryption"
    deletion_window_in_days = 10
}

resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "terraform.bucket-new"

    tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Owner       = "harsh"
    Project     = "storage"
    Department  = "IT"
    }

    server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_kms_key.arn
        }
    }
    }

    lifecycle_rule {
    id      = "delete-30-days"
    enabled = true

    expiration {
        days = 30
        }
    }
}
