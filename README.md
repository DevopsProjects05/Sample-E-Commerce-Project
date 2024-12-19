# E-Commerce Project

This is a **Simple e-commerce project** designed to showcase core **DevOps principles** and tools. The project includes **frontend development** with static assets, served using **NGINX** as the backend. It demonstrates a complete DevOps lifecycle with tools like **Docker, Jenkins, Terraform, HashiCorp Vault,** and **Ansible**. The project also incorporates **monitoring, code quality assurance, and security** using **Prometheus, SonarQube, Trivy, and TSEC.**

---

## **Project Overview**
- **Frontend:** HTML, CSS, JavaScript
- **Backend:** Initially Node.js and Express.js, later replaced with **NGINX** for static file serving.
- **DevOps Tools:**
  - **Git** - Version control.
  - **NGINX** - Web server.
  - **Jenkins** - CI/CD pipeline.
  - **Docker** - Containerization.
  - **Docker Compose** - Multi-container orchestration.
  - **Terraform** - Infrastructure as Code.
  - **HashiCorp Vault** - Secrets management.
  - **Prometheus** - Monitoring and observability.
  - **SonarQube** - Code analysis and quality assurance.
  - **Ansible** - Configuration management.
  - **Trivy** - Security and Vulnerability Scanning
  - **TSEC (Terraform Security Checks)** -  Infrastructure Security.

---

## **Project Features**
1. **Static Frontend**:
   - Responsive design using **Bootstrap**.
   - Links to external product catalogs (e.g., Amazon).
   - Dynamic rendering of product cards using JavaScript.
   
2. **Backend with NGINX**:
   - Serves static assets (HTML, CSS, JS) efficiently.
   - Configured for optimal performance and reliability.

3. **DevOps Workflow**:

    **1. Automated Code Management with Git:**

      - All project files and configurations are version-controlled using Git.
      - Hosted on GitHub for easy collaboration and CI/CD pipeline integration.

    **2. Automated Build and Deployment with Jenkins:**

     -  Jenkins is configured to pull code changes from the GitHub repository.
     - Jenkins triggers the build process using the Dockerfile and other deployment scripts.
     - Supports automated deployment to staging and production environments.
     
    **3. Containerization with Docker:**

     - The application is containerized using a Dockerfile, ensuring consistency across different environments.
      - The Docker image is created and stored locally or pushed to a container registry for deployment.
  
    **4. Infrastructure Automation with Terraform:**

    - Cloud resources, such as EC2 instances, security groups, and networking, are provisioned using Terraform.
    - Secrets management for Terraform is integrated with HashiCorp Vault.
  
    **5. Secrets Management with HashiCorp Vault:**

    - Vault is used to securely manage and provide dynamic secrets for the application and infrastructure.
    - Terraform pulls sensitive credentials (e.g., AWS keys) directly from Vault.
    
   **6. Code Quality Assurance with SonarQube:**

      - SonarQube analyzes the code for bugs, vulnerabilities, and code smells.
      - Ensures high code quality before deployment.

    **7. Security and Vulnerability Scanning:**

      - Trivy scans Docker images for vulnerabilities.
      - TSEC (Terraform Security Checks) ensures the infrastructure code follows best practices.

    **8. Monitoring and Observability with Prometheus:**

      - Application and infrastructure metrics are collected and visualized.
      - Alerts are configured for performance or availability issues.
      
    **9. Configuration Management with Ansible:**

      - Ansible is used for automating server configuration and application deployment.

---

![Image showing the output of the program](/Tools-used1.jpg)


## **Project Structure**
---
```
Sample-E-Commers-Project/ 
├── index.html                          # Main HTML file for the webpage 
├── public/                             # Static assets 
  ├── styles.css                        # CSS styles 
  ├── script.js                         # JavaScript for dynamic rendering   
├── server.js                           # (Initially Node.js backend, now replaced by NGINX) 
├── Docker                              # Docker configuration for containerizing the project 
  ├── Dockerfile                                                               
├── Jenkinsfile                         # CI/CD pipeline configuration 
├── prometheus/                         # Prometheus configuration files 
  ├── prometheus.yml                    # Prometheus configuration file  
  └── alerts.yml                        # Alerts configuration 
├──Terraform/                           # Terraform scripts for cloud infrastructure │ 
  ├── main.tf                           # Main Terraform configuration file  
  ├── variables.tf                      # Variables for infrastructure parameters │ 
  └── outputs.tf                        # Outputs for infrastructure details 
├──Terraform-with-Vault                 # Terraform-with-vault scripts for cloud infrastructure & vault to fetch keys │ 
  ├── main.tf                           # Main Terraform-with-vault configuration file & fetch data from vault  
  ├── variables.tf                      # Variables for infrastructure parameters, tocken and keys │ 
  └── outputs.tf
└── README.md                           # Project documentation
```

---

## **Technologies Used**
### **Frontend**
- **HTML/CSS**: For creating a responsive UI.
- **JavaScript**: For dynamic rendering of content.
- **Bootstrap**: For responsive design and styling.

### **Backend**
- **NGINX**: Used as a static file server for the application.



---

## **Setup Instructions**
Follow these steps to set up and run the project locally or on a server.

**Pre-Requities**
- Git Should be installed

```bash
yum install git -y
```

### **Clone the Repository**
```bash
git clone https://github.com/DevopsProjects05/Sample-E-Commers-Project.git
```
```bash
cd Sample-E-Commers-Project/
```
### **NGINX Setup**

 **Install NGINX**:
  ```bash
  sudo yum update -y
   ```
  ```
  sudo yum install nginx -y
  ```
  **Start the NGINX Service:**
  ```
  sudo systemctl start nginx
  ```
  ```
sudo systemctl enable nginx
```
- Verify NGINX is running:
 ```
 sudo systemctl status nginx
 ```
- Open your browser and navigate to your server's IP address (http://<your-server-ip>). You should see the default NGINX welcome page. 

## Configure NGINX to Serve Your Application

### Move Your Files to the NGINX Web Root:
- NGINX serves static files from `/usr/share/nginx/html` by default.

- Move your project files (HTML, CSS, and JS) to this directory:

**Move project files to the NGINX web root:**
  ```bash
  sudo mv * /usr/share/nginx/html/
  ```
#### Ensure the directory contains:

```
/usr/share/nginx/html/
├── index.html
├── public/
│   ├── styles.css
│   └── script.js
```
#### Edit the NGINX Configuration File (If you modify)

- Open the NGINX configuration file
```
sudo nano /etc/nginx/nginx.conf
```
- Modify the server block to point to your files:
```
server {
    listen 80;
    server_name localhost;

    root /usr/share/nginx/html;             # Path to your project files
    index index.html;                       # Default file to load

    location / {
        try_files $uri /index.html;         # Serve the application
    }

    location /public/ {
        root /usr/share/nginx/html;         # Serve static assets like CSS and JS
    }

    error_page 404 /404.html;               # Optional: Custom 404 page
}

```
- Save and exit (Ctrl+O, Enter, Ctrl+X).

#### Test the NGINX Configuration:

- Before reloading NGINX, ensure the configuration is correct:
```
sudo nginx -t
```
- If there are no errors, reload NGINX to apply the changes:
```
sudo systemctl reload nginx
```

### Open Firewall Ports

Ensure that port 80 (HTTP) is open to allow incoming traffic.

- **For AWS EC2:**

- Go to your EC2 instance's security group settings.
- Add an inbound rule to allow HTTP (port 80) traffic.

### Access Your Application

- Open your browser and navigate to http://your-server-ip:80
- Your finalized project should now be served by NGINX.....
---

### Contributing
Feel free to fork this repository and submit pull requests. Contributions are welcome!

**[Click here to Deploy Sample E-commerce Application Using Docker](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Docker)**

**[Click here to Deploy Sample E-commerce Application Using Docker-Compose](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Docker-Compose)**

**[Click here to Deploy Sample E-commerce Application Using Terraform ](https://github.com/DevopsProjects05/Sample-E-Commers-Project/tree/main/Terraform)**