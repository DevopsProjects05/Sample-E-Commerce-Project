
# Automating Docker Image Security Scanning with Jenkins and Trivy

This project demonstrates how to automate vulnerability scanning of Docker images using Trivy integrated with Jenkins. It includes steps to configure an EC2 instance, install prerequisites, set up Jenkins, and create a pipeline to build Docker images, scan them with Trivy, and archive the reports.

---

## Features

- **Automated Docker Builds**: Jenkins automates the creation of Docker images.
- **Vulnerability Scanning**: Trivy scans Docker images for vulnerabilities and generates reports.
- **Email Notifications**: Developers are notified of scan results via email.
- **Artifact Archival**: Trivy reports are archived in Jenkins for easy access.


![](/Docker-Trivy/Docker-Trivy.jpg)



## Setup Instructions

### 1. Create an EC2 Instance

- Launch an Amazon EC2 instance with minimal configuration (e.g., t2.medium).
- Use Amazon Linux 2 as the operating system.

### 2. Install Prerequisites

#### a. Connect to the Instance

- Use SSH to connect:
  ```bash
  ssh -i your-key.pem ec2-user@<instance-ip>
  ```

#### b. Update the System

- Update the system packages:
  ```bash
  sudo yum update -y
  ```

#### c. Install Git

- Install Git for source code management:
  ```bash
  sudo yum install git -y
  ```

#### d. Install Docker

1. Install Docker:
   ```bash
   sudo yum install docker -y
   ```
2. Install Docker Compose:
   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   ```
3. Start and enable Docker:
   ```bash
   sudo systemctl start docker
   sudo systemctl enable docker
   ```
4. Add the `ec2-user` to the Docker group:
   ```bash
   sudo usermod -aG docker ec2-user
   ```
   **Why?**: Adding the `ec2-user` to the Docker group allows the user to execute Docker commands without `sudo`. This simplifies automation scripts and Jenkins integration.

#### e. Install Java

- Install Java (required for Jenkins):
  ```bash
  amazon-linux-extras enable corretto17
  sudo yum install -y java-17-amazon-corretto
  ```

#### f. Install Jenkins

1. Add the Jenkins repository and key:

   ```bash
   sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
   sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
   ```

2. Install Jenkins:

   ```bash
   sudo yum install jenkins -y
   sudo systemctl enable jenkins
   sudo systemctl start jenkins
   ```

3. Add Jenkins to the Docker group:

   ```bash
   sudo usermod -aG docker jenkins
   ```

   **Why?**: Jenkins requires access to the Docker daemon to execute Docker commands. Adding Jenkins to the Docker group grants these permissions.

4. Restart Jenkins and Docker:

   ```bash
   sudo systemctl restart jenkins
   sudo systemctl restart docker
   ```

#### g. Install Trivy

1. Install Trivy:
   ```bash
   curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh
   ```
2. Move Trivy to a global directory:
   ```bash
   sudo mv /root/bin/trivy /usr/local/bin/trivy
   ```
   **Why?**: Placing Trivy in `/usr/local/bin` ensures it is accessible to all users, including Jenkins.

---

### 3. Access Jenkins

1. Navigate to Jenkins in your browser:
   ```
   http://<instance-ip>:8080
   ```
2. Unlock Jenkins using the initial admin password:
   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```
3. Install the recommended plugins and create an admin user.

---

### 4. Install Jenkins Plugins

- Install the following plugins:
  - **Git Plugin**
  - **Docker Plugin**
  

---

### 5. Update Jenkins Environment Variables

1. If Trivy is not accessible, update the PATH environment variable:
   - Go to **Manage Jenkins** → **Configure System** → **Global Properties**.
   - Add the following PATH:
     ```
     /root/bin:/usr/local/bin:/usr/bin:/bin
     ```
2. Restart Jenkins:
   ```bash
   sudo systemctl restart jenkins
   ```

---



### 6. Configure the Jenkins Pipeline

1. Create a **freestyle job** in Jenkins.

2. Use the following GitHub repository:

   ```
   https://github.com/DevopsProjects05/Sample-E-Commerce-Project.git
   ```

   - Branch: `main`

3. Add the following shell commands in the **Build** section:

   ```bash
   cd Docker-Compose
   docker build -t nginx-image .
   trivy image nginx-image > trivy-report-nginx-image.txt
   ```

4. Configure **Post-build Actions**:

   - **Archive the Artifacts**:
     ```
     trivy-report-nginx-image.txt
     ```
   - **E-mail Notification**:
     - Add the developer's email address.
     - Jenkins will send the Trivy report after each build.

---

## Additional Notes

1. **Adding Users to Groups**:

   - **`ec2-user`**\*\* to Docker Group\*\*: Grants non-root users access to Docker commands.
   - **`jenkins`**\*\* to Docker Group\*\*: Allows Jenkins to interact with the Docker daemon for automation tasks.

2. **Trivy Scan**:

   - The Trivy scan checks for vulnerabilities in Docker images.
   - The `--exit-code 1` option ensures the build fails if high or critical vulnerabilities are found.

---

## Project Output

- The Trivy report (`trivy-report-nginx-image.txt`) includes:
  - Vulnerability details categorized by severity (LOW, MEDIUM, HIGH, CRITICAL).
  - Recommendations for remediation.

---



