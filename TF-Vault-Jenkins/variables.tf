variable "aws_access_key" {
  description = "AWS Access Key for authentication"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key for authentication"
  type        = string
}

variable "region" {
  default = "ap-south-1" # Replace with your desired AWS region
}

variable "key_pair" {
  description = "The name of the AWS key pair for SSH access"
  default     = "DevOps_Practice" # Replace with your key pair
}

variable "ami" {
  default = "ami-0fd05997b4dff7aac"    #Replace with your ami id
}

variable "vault_token" {
  description = "Token to authenticate with Vault"
  type        = string
}