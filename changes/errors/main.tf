provider "aws" {
    region = "us-west-2" 
}

resource "aws_instance" "ec2" {
    ami = "ami-0129bfde49ddb0ed6"
    # instance_type = var.type
}