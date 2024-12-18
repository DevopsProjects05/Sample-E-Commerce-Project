# Sample E-commerce Application Deployment Using Docker Compose

This guide explains how to deploy the **Sample E-commerce Application** using Docker Compose on an EC2 instance.

---

## Prerequisites

  **AWS EC2 Instance**:
   - Launch an EC2 instance with the following configuration:
     - OS: Amazon Linux 2 / Ubuntu 20.04 LTS
     - Security Group: Allow inbound traffic on ports **22 (SSH)**, **80 (HTTP)**
   - Ensure you have your private key (`.pem`) file to connect to the EC2 instance.

  **Tools Installed on EC2**:
   - **Git** for cloning the repository.
   - **Docker** and **Docker Compose** for building and running the application.

---

## Steps to Deploy
Once **Access Your EC2 Instance** Switch to sudo privilege:
```bash
sudo su -
```
**Update the Server**
- Update the system packages
```bash
sudo yum update -y   # For Amazon Linux
sudo apt update -y   # For Ubuntu
```
**Install Docker and Docker Compose**
- Install Docker
```bash
sudo yum install docker -y     # Amazon Linux
sudo apt install docker.io -y  # Ubuntu
```
- Install Docker Compose:
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
- Verify installation
```bash
docker --version
docker-compose --version
```
- Start Docker and enable it to start at boot
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
cd Sample-E-Commers-Project/Docker
```
**Configure Docker Compose**
Ensure the `docker-compose.yml` file is present in the directory. Below is an example of the Docker Compose configuration
```bash
version: '3.8'

services:
  web:
    build:
      context: .                                        # Build the image from the Dockerfile in the current directory
    ports:
      - "80:80"                                         # Map port 80 in the container to port 8080 on the host
    volumes:
      - ./index.html:/usr/share/nginx/html/index.html   # Mount the local index.html file to NGINX's web root
      - ./public:/usr/share/nginx/html/public           # Mount the local public folder to Nginx public folder
    restart: always
```

**Deploy the Application**
- Use Docker Compose to deploy the application
```bash
docker-compose up -d
```
**Verify Deployment**
- Access your website by opening the following URL in your browser
```bash
http://<your-public-ip>:80
```
- **Note**: Ensure you do not use https://, as the application is not configured for HTTPS.

## Here’s What You Should See
**After navigating to the public IP address of your EC2 instance in the browser, you should see a webpage similar to the one below:**

![](/Docker-Compose/Webpage.jpg)

### Contributing
Feel free to fork this repository and submit pull requests. Contributions are welcome!

**`This **README.md** provides all necessary details to deploy your project using Docker Compose. Let me know if you want to add more specific details or make further modifications! 🚀`**


**[Click here to Deploy Sample E-commerce Application Using Docker](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Docker)**
**[Click here to Deploy Sample E-commerce Application Using Terraform ](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Terraform)**