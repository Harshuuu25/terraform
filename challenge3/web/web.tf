resource "aws_instance" "web" {
    ami           = "ami-0129bfde49ddb0ed6"
    instance_type = var.instance_type
    security_groups = [module.sg.sg_name]
    user_data     = file(var.user_data_path)
    
    tags = {
        Name = "Web Server"
    }
}

module "eip" {
    source = "../eip"
    instance_id = aws_instance.web.id
}

output "pub_ip" {
    value = module.eip.PublicIP
}

module "sg" {
    source = "../sg"
}

# output "instance_id" {
#     value = aws_instance.web.id
# }