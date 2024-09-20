provider "aws" {
    region = "eu-north-1"
}

variable "vpcname" {
    type = string
    default = "TerraformVPc" 
}

resource "aws_vpc" "TerraformVPc" {
    cidr_block = "192.168.0.0/24"

    tags = {
        name = var.vpcname
        owner = "harsh"
    }
}

output "vpcid" {
    value = aws_vpc.TerraformVPc.id
}