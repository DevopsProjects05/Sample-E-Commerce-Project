# Step-by-Step Manual SonarQube Setup Guide

This document provides detailed steps to install, configure, and use SonarQube for code analysis on an AWS EC2 instance. It includes all the necessary commands, configurations, and workflow to ensure a smooth setup.

---

## Create an EC2 Instance

1. Launch an **Amazon Linux EC2 instance** with the following specifications:
   - **Instance Type**: `t2.medium`
   - **Security Group**:
     - Port 22 (SSH)
     - Port 9000 (SonarQube)
     - Port 80 (HTTP)

Ensure the instance has sufficient resources to run SonarQube smoothly.

---

## 1. Setting Up SonarQube on EC2

### **Initial Configuration**

1. SSH into the EC2 instance and gain `sudo` privileges:

   ```bash
   ssh -i <your-key.pem> ec2-user@<your-ec2-ip>
   ```
   ```bash
   sudo su -
   ```

2. Update the system and install required packages:

   ```bash
   yum update -y
   ```
   ```bash
   yum install git docker -y
   ```

3. Start and enable Docker:

   ```bash
   systemctl start docker
   ```
   ```bash
   systemctl enable docker
   ```

4. Create and run a SonarQube container:

   ```bash
   docker run -d --name sonarcontainer -p 9000:9000 sonarqube:latest
   ```

5. Access SonarQube in the browser:

   - URL: `http://<your-ec2-ip>:9000`
   - Login: Username: `admin`, Password: `admin` (you will be prompted to reset the password).

---

## 2. Configuring SonarQube

### **Create a New Project in SonarQube**

1. Log in to SonarQube.
2. Click **Create New Project** and provide the project name (e.g., `Sample E-Commerce Project`).

### **Generate an Authentication Token**

1. Navigate to **My Account > Security**.
2. Under **Generate Tokens**, enter a token name (e.g., `SampleProjectToken`).
3. Select **Project Analysis** from the dropdown.
4. Click **Generate** and copy the token. (Save it securely; it will not be displayed again.)

---

## 3. Installing Sonar Scanner

### **Download and Install Sonar Scanner**

1. Create a directory for Sonar Scanner:

   ```bash
   mkdir -p /downloads/sonarqube
   ```
   ```bash
   cd /downloads/sonarqube
   ```

2. Download the latest Sonar Scanner:

   ```bash
   wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip
   ```
   ```bash
   unzip sonar-scanner-cli-5.0.1.3006-linux.zip
   ```
   ```bash
   sudo mv sonar-scanner-5.0.1.3006-linux /opt/sonar-scanner
   ```

3. Add Sonar Scanner to the PATH:

   ```bash
   vi ~/.bashrc 
   ```
   ```bash
   export PATH="/opt/sonar-scanner/bin:$PATH"
   ```
   ```bash
   source ~/.bashrc
   ```

4. Verify the installation:

   ```bash
   sonar-scanner --version
   ```

---

## 4. Analyzing Code with Sonar Scanner

### **Clone a Sample Project**

1. Clone the project repository:
   ```bash
   git clone https://github.com/DevopsProjects05/Sample-E-Commers-Project.git
   cd Sample-E-Commers-Project/
   ```

### **Create the `sonar-project.properties` File**

1. Create and edit the properties file:
   ```bash
   vi sonar-project.properties
   ```
2. Add the following content:
   ```properties
   # Unique project identifier in SonarQube
   sonar.projectKey=SampleECommersProject

   # Display name of the project
   sonar.projectName=Sample E-Commerce Project

   # Directory where source code is located (relative to this file)
   sonar.sources=.

   # URL of the SonarQube server
   sonar.host.url=http://<your-sonarqube-server-ip>:9000

   # Authentication token from SonarQube
   sonar.login=<your-authentication-token>
   ```

### **Run Sonar Scanner**

1. Execute the scanner:
   ```bash
   /opt/sonar-scanner/bin/sonar-scanner
   ```
2. For debugging issues, use:
   ```bash
   /opt/sonar-scanner/bin/sonar-scanner -X
   ```

---

## 5. Viewing Results in SonarQube

1. Open your browser and go to:
   ```
   http://<your-sonarqube-server-ip>:9000
   ```


2. Log in to the SonarQube dashboard.
3. Locate the project (e.g., `Sample E-Commerce Project`).
4. View analysis results, including security issues, reliability, maintainability, and code coverage.

---

### Screenshot of SonarQube Execution and Results

![](/SonarQube/sonar.jpg)

## Notes

- **Instance Type**: SonarQube requires a `t2.medium` instance for optimal performance.
- **Security**: Review and address issues flagged in the SonarQube dashboard.
- **Code Refactoring**: Reduce code duplications and improve coverage to meet Quality Gates.

---

**`This guide provides a complete workflow to install and configure SonarQube for analyzing your projects. Let me know if you need further assistance or enhancements!`**

### Contributing
Feel free to fork this repository and submit pull requests. Contributions are welcome!

**[Click here to Deploy Sample E-commerce Application Using Docker](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Docker)**

**[Click here to Deploy Sample E-commerce Application Using Docker-Compose](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Docker-Compose)**

**[Click here to Deploy Sample E-commerce Application Using Terraform ](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Terraform)**