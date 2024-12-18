variable "access_key" {
  default = "YOUR-ACCESS-KEY"

}

variable "secret_key" {
  default = "YOUR-SECRET-KEY"

}


variable "region" {
  default = "ap-south-1" # Replace with your desired AWS region
}

variable "key_pair" {
  description = "The name of the AWS key pair for SSH access"
  default     = "YOUR-KEYPAIR-NAME" # Replace with your key pair
}

variable "ami" {
  default = "AMI-ID"    #Replace with your ami id
}