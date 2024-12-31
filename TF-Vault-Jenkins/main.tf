



data "vault_kv_secret_v2" "aws_secrets" {
  mount = "secret"          # Mount point of the secrets engine
  name  = "aws"             # Key name under the mount
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  
}


terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
}

provider "vault" {
  address = "http://3.110.213.160:8200/"
  token = var.vault_token
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


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
