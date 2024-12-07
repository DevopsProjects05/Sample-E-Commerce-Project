Monolithic E-commerce Application


Project Overview
This is a simple e-commerce platform built using a monolithic architecture. It includes:

Frontend: A responsive user interface for product browsing and cart management.
Backend: APIs for user authentication, product catalog, and cart functionality.
Technologies Used:
HTML, CSS, JavaScript (Frontend)
Node.js, Express.js (Backend)
Docker (Containerization)
Jenkins (CI/CD)
Terraform (Infrastructure as Code)


Features
User Authentication: Login functionality for users.
Product Catalog: Displays available products with details.
Shopping Cart: Add and view items in the cart.
Project Structure
bash
Copy code
/monolithic-ecommerce
   ├── app.js          # Backend application logic
   ├── package.json    # Node.js dependencies
   ├── public/         # Frontend assets
   │     ├── index.html      # Main HTML file
   │     ├── style.css       # CSS styles
   │     ├── script.js       # Frontend JavaScript
   ├── Dockerfile      # Dockerfile to containerize the app
   ├── docker-compose.yml  # For local development
   └── README.md       # Documentation
Setup Instructions
Prerequisites
Node.js installed on your system.
Docker (for containerization).
Git (for cloning the repository).
Steps to Run the Project Locally
Clone the repository:

bash
Copy code
git clone https://github.com/DevopsProjects05/monolithic-ecommerce.git
cd monolithic-ecommerce
Install dependencies:

bash
Copy code
npm install
Run the application:

bash
Copy code
node app.js
Access the application: Open http://localhost:3000 in your browser.

Docker Setup
Build Docker Image:

bash
Copy code
docker build -t monolithic-ecommerce .
Run Docker Container:

bash
Copy code
docker run -d -p 3000:3000 monolithic-ecommerce
Access the Application: Open http://localhost:3000 in your browser.

Future Enhancements
Add database integration for user data and cart persistence.
Deploy the application to the cloud using Terraform.
Scale to a microservices architecture.
Contributing
Feel free to fork this repository and submit pull requests. Contributions are welcome!

License
This project is licensed under the MIT License.
