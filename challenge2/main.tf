provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "db" {
    ami = var.ami
    instance_type = var.instance_type

    tags = {
        Name = "DB Server"
    }
}

resource "aws_instance" "web" {
    ami           = var.ami
    instance_type = var.instance_type
    security_groups = [aws_security_group.web_traffic.name]
    user_data     = file(var.user_data_path)
    
    tags = {
        Name = "Web Server"
    }
}

resource "aws_eip" "web_ip" {
    instance = aws_instance.web.id
}

resource "aws_security_group" "web_traffic" {
    name = "Allow web traffic"


    dynamic "ingress" {
        iterator = port
        for_each = var.ingress_ports
        content {
            from_port   = port.value
            to_port     = port.value
            protocol    = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        iterator = port
        for_each = var.egress_ports
        content {
            from_port   = port.value
            to_port     = port.value
            protocol    = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

output "PrivateIP" {
    value = aws_instance.db.private_ip
}

output "PublicIP" {
    value = aws_eip.web_ip.public_ip
}
