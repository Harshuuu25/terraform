provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-0129bfde49ddb0ed6"
    instance_type = "t3.micro"
    security_groups = [aws_security_group.nwebtrafic.name]
} 

resource "aws_security_group" "nwebtrafic" {
    name= "Allow HTTPS"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}