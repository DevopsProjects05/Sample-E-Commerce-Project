# Jenkins and SonarQube Setup Guide

---

### Introduction about the project

This project demonstrates the integration of Jenkins and SonarQube to automate code analysis and CI/CD workflows. Jenkins manages the continuous integration process, while SonarQube ensures code quality by identifying issues like bugs, vulnerabilities, and code smells.

This document provides step-by-step instructions to set up Jenkins and SonarQube for automating code analysis and continuous integration.


## Architecture Diagram
**Below is the architecture diagram for this project:**

---
![](/Jenkins-with-sonarqube/Jen-sonar-arc.jpg)

----

## **1. Create EC2 Instances**

1. Launch two **Amazon Linux EC2 instances** with the following specifications:
   - **Instance Type**: `t2.medium`
   - **Security Group**:
     - Port 22 (SSH)
     - Port 8080 (Jenkins)
     - Port 9000 (SonarQube)

---

## **2. Install Git and Docker**

Run these commands on both instances:

```bash
sudo yum update -y
```
```bash
sudo yum install git docker -y
```
```bash
sudo systemctl start docker
```
```bash
sudo systemctl enable docker
```

---

## **3. Jenkins Installation**

Run these commands on the **Jenkins server instance**:

1. Add the Jenkins repository:

   ```bash
   sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
   sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
   sudo yum upgrade -y
   ```

2. Install Java 17:

   ```bash
   amazon-linux-extras enable corretto17
   sudo yum install -y java-17-amazon-corretto
   ```
   ```bash
   java -version
   ```

3. Install Jenkins:

   ```bash
   sudo yum install jenkins -y
   ```

4. Enable and start Jenkins:

   ```bash
   sudo systemctl enable jenkins
   ```
    ```bash
   sudo systemctl start jenkins
   ```
    ```bash
   sudo systemctl status jenkins
   ```

---

## **4. Access Jenkins**

1. Open your browser and access Jenkins at:

   ```
   http://<Jenkins-Instance-IP>:8080
   ```

2. Unlock Jenkins:

   - Find the initial admin password in `/var/lib/jenkins/secrets/initialAdminPassword`.
   - Enter the password and proceed.

3. Create an admin user:

   - Username: `Nuthan`
   - Password: `Panny@123`

4. Install the suggested plugins.

---

## **5. Create a Jenkins Pipeline**

1. Go to **New Item** and select **Freestyle Project**.

2. Name the project `Automated Pipeline` and click OK.

3. Under **Source Code Management**:

   - Select **Git**.
   - Provide the repository URL:
     ```
     https://github.com/DevopsProjects05/Sample-E-Commerce-Project.git
     ```
   - Branch: `main`

4. Under **Build Triggers**:

   - Check: `GitHub hook trigger for GITScm polling`.

5. Configure GitHub Webhooks:

   - Open GitHub: **Settings > Webhooks > Add Webhook**.
   - Provide the Jenkins URL:
     ```
     http://<Jenkins-Instance-IP>:8080/github-webhook/
     ```
   - Select **Let me select individual events** and check only:
     - `Pushes`
     - `Pull Requests`

6. Save the pipeline and click **Build Now**.

---

## **6. SonarQube Setup**

### **SonarQube Server Setup**

Run these commands on the **SonarQube server instance**:

1. Update the server and **install Java 17**:

   ```bash
   sudo yum update -y
   ```
    ```bash
   amazon-linux-extras enable corretto17
   sudo yum install -y java-17-amazon-corretto
   ```

2. Run SonarQube in a Docker container:

   ```bash
   docker run -d --name sonarcontainer -p 9000:9000 sonarqube:latest
   ```

3. Access SonarQube:

   - URL: `http://<SonarQube-Instance-IP>:9000`
   - Login credentials:
     - Username: `admin`
     - Password: `admin`
   - Reset the password to: `Example@12345`.

---

### **Create a Project in SonarQube**

1. Log in to SonarQube.
2. Create a project:
   - Project Display Name: `Sample E-Commerce Project`
   - Project Key: `Sample-e-commerce-project`
   - Main Branch Name: `main`
3. Select **Global Configuration** and choose **With Jenkins**.
4. Select **GitHub** and create a `Jenkinsfile`.
5. Copy the `sonar.project-key`.

---

### **Generate an Authentication Token**

1. Go to **Profile > My Account > Security**.
2. Generate a token:
   - Name: `SonarQube-Token`.
   - Type: `Global Analysis Token`.
3. Copy the token (e.g., `sqa_21564165421654216415421545`).

---

## **7. Configure Jenkins for SonarQube**

### **Install Plugins**

1. Install the following plugins:

   - **SonarQube Scanner**
   - **SSH2 Easy**

2. Restart Jenkins (recommended).

---

### **Add SonarQube Scanner**

1. Go to **Manage Jenkins > Global Tool Configuration**.
2. Scroll to **SonarQube Scanner** and click **Add SonarQube Scanner**:
   - Name: `SonarScanner`.
   - Check: `Install Automatically`.
3. Apply and Save.

---

### **Add SonarQube Server**

1. Go to **Manage Jenkins > Configure System**.
2. Scroll to **SonarQube Servers** and click **Add SonarQube**:
   - Name: `Sonar-Server`.
   - Server URL: `http://<SonarQube-Instance-IP>:9000`.
   - Authentication Token:
     - Add a new credential:
       - Kind: `Secret Text`
       - Secret: `<Your-SonarQube-Token>`
       - ID: `Sonar-Token`
     - Select the token.
3. Save the configuration.

---

## **8. Test the Setup**

1. Go to the Jenkins pipeline and click **Build Now**.
2. Check the console output for the build process.
3. Open the SonarQube dashboard to see the analysis results.

---

#### YOU WILL BE ABLE TO SEE THE BELOW RESULT PAGE:

---

![](/Jenkins-with-sonarqube/JEN-SONAR.jpg)

---

This guide ensures a complete setup of Jenkins and SonarQube for automated code analysis and continuous integration. Let me know if you encounter any issues!

**[Click here to Deploy Sample E-commerce Application Using Docker](https://github.com/DevopsProjects05/Sample-E-Commerce-Project/tree/main/Docker)**

**[Click here to Deploy Sample E-commerce Application Using Docker-Compose](https://github.com/DevopsProjects05/Sample-E-Commerce-Project/tree/main/Docker-Compose)**

**[Click here to Deploy Sample E-commerce Application Using Terraform ](https://github.com/DevopsProjects05/Sample-E-Commerce-Project/tree/main/Terraform)**




