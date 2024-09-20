provider "aws" {
    region = "eu-north-1"
}

module "ec2" {
    source = "./ec2"
    for_each = toset(["dev", "test", "proked"])
}

