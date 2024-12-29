# Terraform with TFscan and Jenkins

## Install Git
Install Git using the following command:
```bash
sudo yum install git -y
```

## Install Terraform
Install Terraform by running these commands:
```bash
sudo yum install -y yum-utils
```
```bash
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
```
```bash
sudo yum -y install terraform
```

## Install Java
Enable and install Amazon Corretto 17:
```bash
amazon-linux-extras enable corretto17
sudo yum install -y java-17-amazon-corretto
```

## Install Jenkins
Install Jenkins using the following commands:
```bash
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
```
```bash
sudo yum install jenkins -y
```
```bash
sudo systemctl enable jenkins
```
```bash
sudo systemctl start jenkins
```
```bash
sudo systemctl status jenkins
```

## Install TFscan
Install TFscan with the following command:
```bash
curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash
```

## Add /usr/local/bin to PATH
1. Check your current PATH:
   ```bash
   echo $PATH
   ```
2. Add `/usr/local/bin` to your PATH permanently:
   - Edit the `.bashrc` or `.bash_profile` file:
     ```bash
     vi ~/.bashrc
     ```
   - Add the following line:
     ```bash
     export PATH=$PATH:/usr/local/bin
     ```
3. Apply the changes:
   ```bash
   source ~/.bashrc
   ```
4. Verify TFscan installation:
   ```bash
   tfsec --version
   ```

## Access Jenkins
Access Jenkins by navigating to `http://<instance-ip>:8080` in your browser. Follow the setup instructions to unlock Jenkins and create a user.

## Create Terraform Folder
Create a folder for Terraform on your instance:

##### Example Terraform Files
**main.tf:**
```hcl
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = "public-read"
}
```

**variable.tf:**
```hcl
variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "example-bucket"
}
```
Move files to the path:
```bash
mkdir -p /var/lib/jenkins/terraform 
```
```bash
cp -r /root/terraform /var/lib/jenkins/terraform/
```


## Steps to Integrate with Jenkins
1. Add the script in Jenkins:
   - Go to your Jenkins job configuration.
   - Under **Build > Execute Shell**, add:
     ```bash
     cd /var/lib/jenkins/terraform/terraform
     tfsec . > tfsec-report.txt          # Ensure the `tfsec-report.txt` is available in the workspace folder.
     ```


### Moving `tfsec-report.txt` to Workspace
If you find `tfsec-report.txt` in `/var/lib/jenkins/terraform/terraform`, move it to `/var/lib/jenkins/workspace/<job-name>`:
```bash
mv /var/lib/jenkins/terraform/terraform/tfsec-report.txt /var/lib/jenkins/workspace/<job-name>
```
Replace `<job-name>` with your Jenkins job name.

2. Run the build and Generate a Report

### Issues Detected by TFscan
- **Issue:** S3 bucket is publicly accessible.
- **Severity:** High.
- **Recommendation:** Change ACL to prevent public access.

### Build and Access the Report
1. Run the Jenkins job.
2. After the job completes, navigate to the workspace in Jenkins.
3. Locate and download the `tfsec-report.txt` file to share the report.

## Fix Issues in Terraform Files
Update your `main.tf` file to resolve detected issues:
```hcl
resource "aws_s3_bucket" "example" {
    bucket = var.bucket_name
    acl    = "private" # Fixed from public-read
}
```


## Project Output
### Jenkins Build Console Output
- All Terraform files are scanned for potential issues using TFscan.
- The `tfsec-report.txt` is generated and archived in Jenkins.

### TFscan Report Highlights
- Issues detected:
  - S3 bucket is publicly accessible.
- Severity levels:
  - Critical: 0
  - High: 1
  - Medium: 0
  - Low: 0

### Steps Completed
1. Jenkins job configured successfully.
2. Terraform files scanned without errors.
3. `tfsec-report.txt` archived and available for download.

### Final Outcome
- All issues resolved in `main.tf`.
- Terraform setup verified and secured as per best practices.
- Jenkins integration fully operational.

### Contributing
Feel free to fork this repository and submit pull requests. Contributions are welcome!

**[Click here to Deploy Sample E-commerce Application Using Docker](https://github.com/DevopsProjects05/Sample-E-Commerce-Project/tree/main/Docker)**

**[Click here to Deploy Sample E-commerce Application Using Docker-Compose](https://github.com/DevopsProjects05/Sample-E-Commerce-Project/tree/main/Docker-Compose)**

**[Click here to Deploy Sample E-commerce Application Using Terraform ](https://github.com/DevopsProjects05/Sample-E-Commerce-Project/tree/main/Terraform)**
