provider "aws" {
    region = "eu-north-1"
}

resource "aws_db_instance" "myRDS" {
    allocated_storage    = 20
    engine               = "mysql"
    engine_version       = "8.0.39"
    instance_class       = "db.t3.micro"  # Update this to a supported class
    db_name              = "myDB"
    username             = "bob"
    password             = "your_password"
    port                 = 3306
    publicly_accessible  = false
    skip_final_snapshot  = true
}

