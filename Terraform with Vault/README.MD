# Terraform + Vault Integration to Deploy AWS EC2 Instance

This repository demonstrates how to integrate **HashiCorp Vault** with **Terraform** to provision an AWS EC2 instance. Vault is used to securely fetch dynamic AWS credentials, which Terraform then uses to deploy the EC2 instance.

---

## **Features**
- **Secure Secrets Management**:
  - AWS credentials are dynamically fetched from HashiCorp Vault's AWS Secrets Engine.
  - Secrets are never hardcoded in Terraform files.
- **EC2 Provisioning**:
  - A t2.micro instance is provisioned in AWS.
  - The instance uses a specified AMI and is tagged for identification.

---

## **Prerequisites**
1. **Terraform** installed:
   - Install Terraform from the official website: [Terraform Downloads](https://www.terraform.io/downloads.html).
   - Verify installation:
     ```bash
     terraform -version
     ```

2. **Vault** installed and running:
   - Install Vault from the official website: [Vault Downloads](https://developer.hashicorp.com/vault/downloads).
   - Verify installation:
     ```bash
     vault -version
     ```

3. **AWS Account**:
   - Ensure you have an active AWS account.
   - IAM credentials with permissions to manage EC2 and Security Groups.


4. **SSH Key Pair**:
   - Create a key pair in the AWS Management Console.
   - Save the `.pem` file securely and update the `key_name` in `variables.tf`.

---

## **Step-by-Step Instructions**

### **1. Setting Up Vault**

1. **Start Vault**:
   - Run Vault in dev mode:
    ```bash
     vault server -dev -dev-listen-address="0.0.0.0:8200"
    ```
   - Note the **root token** displayed after starting Vault.

2. **Export Vault Environment Variables**:
     ```bash
     export VAULT_ADDR="http://0.0.0.0:8200"
     export VAULT_TOKEN="<root-token>"
     ```

3. **Verify Vault Status:**
   ```bash
   vault --version
   ```
4. **Enable the AWS Secrets Engine:**
    ```bash
   vault secrets enable -path=aws aws
    ```
Configure AWS Root Credentials:

5. **Replace `<ACCESS_KEY>` and `<SECRET_KEY>` with your AWS credentials:**
    ```bash
    vault write aws/config/root \
    access_key="<ACCESS_KEY>" \
    secret_key="<SECRET_KEY>" \
    region="us-east-1"   # Replace with your region
    ```
6. **Create a Role for AWS Credentials:**
   ```bash
   vault write aws/roles/dev-role \
    credential_type=iam_user \
    policy_document=-<<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "sts:GetCallerIdentity"
            ],
            "Resource": "*"
        }
    ]
    }
   EOF
   ```    

7. **Verify Role Configuration:**
   ```bash
   vault read aws/roles/dev-role
   ```
8. **Test AWS Credentials from Vault:**
    ```bash
    vault read aws/creds/dev-role
    ```

## 2. Setting Up Terraform
1. **Clone the Repository:**
    ```bash
    git clone <repository-url>
    ```
    ```bash
    cd <repository-directory>
    ```
2. **Add the following content:**
    ```bash
    vault_token = "<your-vault-token>" # Replace with your Vault token
    ```
3. **Terraform Commands:**

- Initialize Terraform:
    ```bash
    terraform init
    ```
- Format the Terraform files:
    ```bash
    terraform fmt
    ```
- Validate the Terraform configuration:
    ```bash
    terraform validate
    ```
- Plan the Terraform deployment:
    ```bash
    terraform plan
    ```
- Apply the Terraform configuration:
    ```bash
    terraform apply -auto-approve
    ```

## Expected Outcome
1. **EC2 Instance:**

- A t2.micro EC2 instance is provisioned in the us-east-1 region.
- The instance uses the AMI ID specified in the main.tf file.
- The instance is tagged with Name: Vault-Terraform-Demo.

2 **Dynamic Credentials:**

- AWS access and secret keys are dynamically fetched from Vault's AWS Secrets Engine during execution.
  
3. **Security:**

- AWS credentials are not stored in the codebase or environment, ensuring secure operations.

## Preview of the Deployed Web Application
**Once the Terraform with vault deployment completes, navigate to the public IP address of your instance in the browser (e.g., http://<public-ip>)**

![](/Sample-E-Commers-Project/Terraform%20with%20Vault/Webpage.jpg)

## Cleanup
To delete the resources created by Terraform:
```bash
terraform destroy -auto-approve
```

## Troubleshooting
### Vault Issues
- Verify Vault is running:
```bash
vault status
```

- Ensure the Vault token is valid:
```bash
vault token lookup
```
### Terraform Issues
- Verify the Vault role path (aws/creds/dev-role) exists:
```bash
vault list aws/creds
```
- Check for typos in the Terraform configuration or environment variables.
### AWS Issues
- Ensure the root credentials configured in Vault have sufficient permissions.
- Verify the region and AMI ID are correct.

## Key Files
`main.tf`: Terraform configuration for Vault integration and EC2 provisioning.
`variables.tf`: Variables for Terraform configuration.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

```
### **Details Added**
1. Complete Vault setup instructions, including installation, configuration, and AWS Secrets Engine setup.
2. Terraform setup steps with precise commands.
3. Troubleshooting for Vault, Terraform, and AWS.
4. Cleanup instructions and expected outcomes.

This README now provides comprehensive instructions for someone to successfully run this project without prior knowledge. Let me know if you’d like additional refinements! 🚀
````
