provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-0129bfde49ddb0ed6"
    instance_type = "t3.micro"
}