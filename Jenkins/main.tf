provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "jenkins_server" {
    ami           = "ami-0dee22c13ea7a9a67"  
    instance_type = "t2.micro"

    tags = {
    Name = "master-jenks"
    }

    user_data = <<-EOF
            #!/bin/bash
            sudo apt update -y
            sudo apt-get install -y fontconfig openjdk-17-jre
            java -version
            sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
                https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
            echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                https://pkg.jenkins.io/debian-stable binary/" | \
                sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
            sudo apt-get update -y
            sudo apt-get install -y jenkins
            sudo systemctl enable jenkins
            sudo systemctl start jenkins
            EOF

    key_name = "jenkins"  


    vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
}

resource "aws_security_group" "jenkins_sg" {
    name        = "jenkins_security_group"
    description = "Allow traffic to Jenkins"

    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["223.233.78.207/32"] 
    }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
    }
    
    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
    }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}
