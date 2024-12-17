provider "vault" {
  address = "http://13.203.86.163:8200/" # Replace with your Vault server address
  token   = var.vault_token              # Vault token
}

provider "aws" {
  region     = "ap-south-1"
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
}

data "vault_generic_secret" "aws_creds" {
  path = "aws/creds/Dev_role"
}







