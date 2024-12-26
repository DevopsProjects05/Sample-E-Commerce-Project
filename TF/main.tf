provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# EC2 Instances for SonarQube and Jenkins
resource "aws_instance" "devops_instances" {
  count          = 2
  ami            = var.ami
  instance_type  = "t2.medium"
  key_name       = "DevOps_Practice"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = count.index == 0 ? "SonarQube" : "Jenkins" # First instance is SonarQube, second is Jenkins
  }



  # User data for instance initialization
  user_data = <<-EOF
    #!/bin/bash
    # Update and install required packages
    sudo yum update -y
    sudo yum install -y git docker

    # Start and enable Docker
    sudo systemctl start docker
    sudo systemctl enable docker

  
  EOF
}

resource "aws_security_group" "allow_tls" {
  name        = "terraform-firewall"
  description = "Managed from Terraform"

  # Ingress Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 80  
    to_port     = 80 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Egress Rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
