provider "aws" {
    region = "eu-north-1"
}

variable "vpcname" {
    type = string
    default = "terravpc"
}

resource "aws_vpc" "terravpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        name = "harsh"
        owner = "HP"
    }
}

output "vpcid" {
    value = aws_vpc.terravpc.id
}