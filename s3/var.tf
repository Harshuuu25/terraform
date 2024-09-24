variable "region" {
    description = "The AWS region to deploy resources"
    default     = "eu-north-1"
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    default     = "terraform.bucket-new"
}

variable "kms_key_description" {
    description = "Description for the KMS key"
    default     = "KMS key for S3 bucket encryption"
}

variable "deletion_window" {
    description = "The number of days before the KMS key is deleted"
    default     = 10
}

variable "bucket_tags" {
    description = "Tags for the S3 bucket"
    type        = map(string)
    default = {
    Name        = "My bucket"
    Environment = "Dev"
    Owner       = "harsh"
    Project     = "storage"
    Department  = "IT"
    }
}
