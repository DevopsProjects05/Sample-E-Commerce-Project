# Terraform EC2 Web Server Deployment

This repository contains Terraform code to provision an **AWS EC2 instance** running **NGINX**. The EC2 instance is configured with a security group to allow HTTP, HTTPS, and SSH access. It clones a GitHub repository, sets up NGINX, and serves the web content from the cloned repository.

---

## **Features**
- Provisions an EC2 instance in AWS.
- Configures a security group to allow:
  - SSH (port 22)
  - HTTP (port 80)
  - HTTPS (port 443)
- Installs and starts **NGINX** on the instance.
- Clones a sample project from a GitHub repository.
- Serves the web content using NGINX.

---

![](/Terraform/tf-aws.jpg)

## **Prerequisites**
1. Install **[Terraform](https://spacelift.io/blog/how-to-install-terraform)**.
2. Install Git
3. Ensure you have an AWS account with:
   - **Access Key** and **Secret Key**.
   - Permissions to create EC2 instances and security groups.
4. Create an EC2 key pair in AWS and update the `key_name` in `variables.tf`.

---

## **Setup Instructions**

### **1. Clone the Repository**
```bash
git git clone https://github.com/DevopsProjects05/Sample-E-Commers-Project
```
```bash
cd Sample-E-Commers-Project/
```
# 2. Update Terraform Variables
Create a `variables.tf` file with the following content:

```bash
region       = "us-east-1"               # Replace with your AWS region
access_key   = "your-access-key"         # Replace with your AWS Access Key
secret_key   = "your-secret-key"         # Replace with your AWS Secret Key
ami          = "ami-12345"               # Replace with a valid Amazon Linux 2 AMI ID for your region
key_pair     = "your-key-pair-name"      # Replace with your EC2 Key Pair

```

#  Terraform Commands
## 1. Initialize Terraform
Run this command to initialize the working directory and download provider plugins:
```bash
terraform init
```
## 2. Format Terraform Code
Format the Terraform configuration files to ensure proper styling:
```bash
terraform fmt
```

## 3. Validate Terraform Configuration
Validate the syntax and configuration:
```bash
terraform validate
```

## 4. Generate an Execution Plan
Create a plan to review the resources Terraform will create:
```bash
terraform plan
```

## 5.Apply the Terraform Configuration
Provision the resources automatically without manual approval:
```bash
terraform apply -auto-approve
```

# Accessing the Web Server
1.Find the Public **IP Address** of the EC2 instance from the Terraform output or AWS Console.

2.Open your browser and navigate to:
```bash
http://<public-ip>
```
## Expected Webpage Output

**After navigating to the public IP address of your EC2 instance in the browser, you should see a webpage similar to the one below:** 

![](/Terraform/Webpage.jpg)

## Cleanup
To delete the resources created by Terraform:
```bash
terraform destroy -auto-approve
```

## Key Files
`main.tf`: Terraform configuration for the EC2 instance and security group.
`variables.tf`: Variables used in the configuration.
`README.md`: Documentation for setting up and using the Terraform code.

## Troubleshooting
1. **Web Content Not Accessible:**

- Verify the security group rules allow inbound traffic on port 80.
- Check the NGINX service status:
```bash
sudo systemctl status nginx
```
Ensure the repository files were moved to `/usr/share/nginx/html/`.

**2.Terraform Errors:**

- Check for typos or misconfigurations in `variables`.
- Validate the syntax using:
```bash
terraform validate
```

---

### **Summary of the README**
- Provides a comprehensive guide for setting up and deploying the Terraform code.
- Includes instructions for Terraform commands like `init`, `fmt`, `validate`, `plan`, and `apply`.
- Covers troubleshooting and cleanup processes.
- Makes it easy for users to replicate and showcase the deployment. 

Let me know if you'd like further modifications or explanations! 🚀

**[Click here to Deploy Sample E-commerce Application Using Docker](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Docker)**

**[Click here to Deploy Sample E-commerce Application Using Docker-Compose](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Docker-Compose)**