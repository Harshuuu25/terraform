variable "ami" {
    default = "ami-0129bfde49ddb0ed6"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "ingress_ports" {
    type        = list(number)
    default     = [80, 443]
}

variable "egress_ports" {
    type        = list(number)
    default     = [80, 443]
}

variable "user_data_path" {
    type        = string
    default     = "C:\\Users\\91828\\Desktop\\terraformX\\challenge2\\server-script.sh"
}