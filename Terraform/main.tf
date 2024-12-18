provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "web_server" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]

  user_data = <<EOF
#!/bin/bash
sudo su -
sudo yum update -y
sudo yum install -y git

# Clone the GitHub repository
git clone https://github.com/DevopsProjects05/Sample-E-Commers-Project
cd Sample-E-Commers-Project/

# Install and start NGINX
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Move the web content to NGINX's web root
sudo mv * /usr/share/nginx/html/

# Test and reload NGINX configuration
sudo nginx -t
sudo systemctl reload nginx
EOF

  tags = {
    Name = "Terraform-EC2-WebServer"
  }
}

resource "aws_security_group" "allow_http_ssh" {
  name_prefix = "allow_http_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
