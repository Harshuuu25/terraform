provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "db" {
    ami = "ami-0129bfde49ddb0ed6"
    instance_type = "t3.micro"
}

resource "aws_instance" "web" {
    ami = "ami-0129bfde49ddb0ed6"
    instance_type = "t3.micro"

    depends_on = [ aws_instance.db ]

}