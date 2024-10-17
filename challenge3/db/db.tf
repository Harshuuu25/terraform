resource "aws_instance" "db" {
    ami = var.ami
    instance_type = var.instance_type

    tags = {
        Name = "DB Server"
    }
}

output "PrivateIP" {
    value = aws_instance.db.private_ip
}
