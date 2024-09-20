provider "aws" {
    region = "us-west-2" 
}

variable "environment" {
    type = string
}

resource "aws_instance" "ec2" {
    ami = "ami-0129bfde49ddb0ed6"
    instance_type = "t2.micro"
    count = var.environment =="prod" ? 1:0
}