# resource "aws_instance" "ec2" {
#     ami = ""
#     instance_type = "t2.micro"
# }

# count example
# resource "aws_instance" "example" {
#     count = 2
#     ami           = ""
#     instance_type = "t2.micro"
# }

# # for_each example
# resource "aws_instance" "example" {
#     for_each = toset(["dev", "test", "prod"])
#     ami           = ""
#     instance_type = "t2.micro"
#     tags = {
#     Name = each.key
#     }
# }