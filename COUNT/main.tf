provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "db" {
    ami = "ami-0129bfde49ddb0ed6"
    instance_type = "t3.micro"
    count = 3
}