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

output "sg_name" {
    value = aws_security_group.web_traffic.name
}