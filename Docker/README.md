# Sample E-commerce Application Deployment Using Docker

This guide will help you deploy the Sample E-commerce Application using Docker on an EC2 instance.

---

## Prerequisites

1. **AWS EC2 Instance**:
   - Launch an EC2 instance with the following configuration:
     - OS: Amazon Linux 2 / Ubuntu 20.04 LTS
     - Security Group: Allow inbound traffic on ports **22 (SSH)**, **80 (HTTP)**, and **443 (HTTPS)**.
   - Make sure to have your private key (`.pem`) file to connect to the EC2 instance.

2. **Tools Installed on EC2**:
   - **Git** for cloning the repository.
   - **Docker** for building and running the application.

---

## Steps to Deploy

Once **Access Your EC2 Instance** Switch to sudo privilege:
```bash
sudo su -
```
**Update your server**
```bash
sudo yum update -y   # For Amazon Linux
sudo apt update -y   # For Ubuntu
```
**Install Required Packages**
- Install Git and Docker
```bash
sudo yum install git docker -y   # For Amazon Linux
sudo apt install git docker.io -y   # For Ubuntu
```
**Start the Docker service**
```bash
sudo systemctl start docker
sudo systemctl enable docker
```
**Clone the Repository**
- Clone the project repository to your instance
```bash
git clone https://github.com/DevopsProjects05/Sample-E-Commers-Project.git
```
- Navigate to the Docker directory
```bash
cd /root/Sample-E-Commers-Project/Docker
```
**Build the Docker Image**
```bash
docker build -t nginx-image .
```
- `nginx-image` is the name of the Docker image.
- The `.` represents the current directory.

**Verify the Docker Image**
- List all Docker images to confirm the image was created successfully.
```BASH
docker images
```
**Run the Docker Container**
- Create and start a Docker container from the image
```bash
docker run -d --name nginx-container -p 80:80 nginx-image
```
- `-d`: Run the container in detached mode.
- `--name`: Name the container as ***nginx-container***.
- `-p 80:80`: Map port 80 in the container to port 80 on the host.

Access Your Website
- Now try to access your website
```bash
http://<your-public-ip>:80
```
- **Note:** Ensure you do not use HTTPS (https://) in the URL, as the application is not configured for HTTPS.

## You will be able to see the below output:
![](/Docker/Webpage.jpg)