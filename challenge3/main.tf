provider "aws" {
    region = "eu-north-1"
}

module "db" {
    source = "./db"
}

module "web" {
    source = "./web"
    instance_id = "ami-0129bfde49ddb0ed6"
}

output "PrivateIP" {
    value = module.db.PrivateIP
}

output "PublicIP" {
    value = module.web.pub_ip
}
