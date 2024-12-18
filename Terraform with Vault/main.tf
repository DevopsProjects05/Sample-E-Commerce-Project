provider "vault" {
  address = "http://<vault-server-ip>:8200" # Replace with your Vault server address
  token   = var.vault_token                # Token from environment or tfvars
}

provider "aws" {
  region     = "us-east-1"    ## Replace with your region
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
}

data "vault_generic_secret" "aws_creds" {
  path = "aws/creds/Dev_role"
}

resource "aws_instance" "web_server" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]

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
