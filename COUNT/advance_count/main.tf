provider "aws" {
    region = "eu-north-1"
}

module "db" {
    source = "./db"
    server_names = ["mariadb","mysql","mssql"]
} 

output "private__IPS" {
    value = module.db.PrivateIP
}