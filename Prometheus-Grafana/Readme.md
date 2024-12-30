## Integrating Prometheus and Grafana with Sample E-Commerce Project

Follow the Step-by-Step Guide to Setting Up Your Application with NGINX.

### Link to Project:

[Sample E-Commerce Project GitHub Repository](https://github.com/DevopsProjects05/Sample-E-Commerce-Project.git)

---

### **Step 1: Set Up the Server**

1. **Instance Requirements**:

   - Use a virtual machine or cloud instance.
   - Recommended instance type:
     - **AWS EC2**: t2.micro or t3.medium (for higher capacity).
     - **RAM**: 2GB minimum.
     - **CPU**: 1-2 cores.

2. **Open Required Ports**:

   - Port **9090**: For Prometheus Web UI.
   - Port **80**: For NGINX (if you’re monitoring it).
   - Port **9113**: For the NGINX Exporter.
   - Port **3000**: For Grafana.
   - Add these to the security group or firewall settings.

---

### **Step 2: Install Prometheus**

1. **Download Prometheus**:
   ```bash
   wget https://github.com/prometheus/prometheus/releases/download/v2.44.0/prometheus-2.44.0.linux-amd64.tar.gz
   ```

2. **Extract and Navigate**:
   ```bash
   tar -xvzf prometheus-2.44.0.linux-amd64.tar.gz
   ```
   ```bash
   cd prometheus-2.44.0.linux-amd64
   ```

3. **Run Prometheus**:
   ```bash
   ./prometheus --config.file=prometheus.yml
   ```
   - Prometheus will start and be accessible at: `http://<your-server-ip>:9090`.
   - To run in the background:
     ```bash
     ./prometheus --config.file=prometheus.yml &
     ```

---

### **Step 3: Set Up NGINX Metrics Exporter**

1. **Download and Extract the Exporter**:
   ```bash
   wget https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v1.4.0/nginx-prometheus-exporter_1.4.0_linux_amd64.tar.gz
   ```
   ```bash
   tar -xvzf nginx-prometheus-exporter_1.4.0_linux_amd64.tar.gz
   ```

2. **Update NGINX Configuration**:
   Open `/etc/nginx/nginx.conf` and locate the server block. Add the following `location /metrics` block inside it:
   ```bash
   vi /etc/nginx/nginx.conf
   ```
   ```nginx
   server {
       listen 80;
       server_name localhost;

       root /usr/share/nginx/html;  # Adjust as needed
       index index.html;

       location / {
           try_files $uri /index.html;
       }

       location /metrics {
           stub_status;
           allow 127.0.0.1;  # Only localhost can access metrics
           deny all;
       }
   }
   ```

3. **Reload NGINX**:
   ```bash
   sudo nginx -t
   ```
   ```bash
   sudo systemctl reload nginx
   ```
   ```bash
   sudo systemctl status nginx
   ```

4. **Start NGINX Exporter**:
   ```bash
   ./nginx-prometheus-exporter -nginx.scrape-uri=http://127.0.0.1/metrics &
   ```
   - Access the metrics at: `http://<your-server-ip>:9113/metrics`.

---

### **Step 4: Configure Prometheus to Scrape Metrics**

1. **Edit Prometheus Configuration**:
   Open the `prometheus.yml` file and Remove existing configurations if indentation issues arise, and replace with the following:
   ```bash
   vi prometheus.yml
   ```
   ```yaml
   global:
     scrape_interval: 15s  # Set the scrape interval to every 15 seconds. Default is 1 minute.
     evaluation_interval: 15s  # Evaluate rules every 15 seconds. Default is 1 minute.

   scrape_configs:
     - job_name: "prometheus"
       static_configs:
         - targets: ["localhost:9090"]

     - job_name: "nginx"
       static_configs:
         - targets: ["localhost:9113"]
   ```

2. **Restart Prometheus**:
   - Stop the running instance and restart Prometheus:
     ```bash
     ./prometheus --config.file=prometheus.yml &
     ```

   - If you encounter the error **"bind: address already in use"**, free the port:
     ```bash
     sudo netstat -tuln | grep 9090    #you will see port is already in use
     ```
     ```bash
     sudo lsof -i :9090   # you will see PID Number
     ```
     ```bash
     sudo kill <PID>
     ```
     Restart Prometheus now:
     ```bash
     ./prometheus --config.file=prometheus.yml &
     ```


---

### **Step 5: Verify the Integration**

1. **Access Prometheus UI**:
   - Open: `http://<your-server-ip>:9090`.

2. **Check Targets**:
   - Go to **Status > Targets**.
   - Ensure that both `prometheus` and `nginx` jobs are listed and marked **UP**.

3. **Run Sample Queries**:
   - Total HTTP requests:
     ```promql
     nginx_http_requests_total
     ```
   - Requests per second:
     ```promql
     rate(nginx_http_requests_total[1m])
     ```

---



### **Steps to Integrate Grafana with Prometheus**

Grafana is a powerful tool for visualizing Prometheus metrics. Here’s how you can set it up and use it:

---

### **Step 1: Install Grafana**

1. **Download and Install Grafana**:
   - On CentOS/Red Hat:
     ```bash
     sudo yum install -y https://dl.grafana.com/oss/release/grafana-10.1.1-1.x86_64.rpm
     ```
   - On Ubuntu/Debian:
     ```bash
     sudo apt-get install -y grafana
     ```

2. **Start the Grafana Service**:
   ```bash
   sudo systemctl start grafana-server
   ```
   ```bash
   sudo systemctl enable grafana-server
   ```

3. **Access Grafana**:
   - URL: `http://<your-server-ip>:3000`
   - Default credentials:
     - Username: `admin`
     - Password: `admin` (you will be prompted to change it).

    ![](/grafana-login.jpg)

---

### **Step 2: Add Prometheus as a Data Source**

1. Log in to Grafana.
2. Navigate to **Configuration > Data Sources**.
3. Click **Add Data Source**.
![](/grafana-dashboard)
4. Select **Prometheus**.
![](/grafana-datasource.jpg)
5. Enter your Prometheus URL:
   ```
   http://<your-server-ip>:9090
   ```
   ![](/grafana-prometheus.jpg)
6. Click **Save & Test** to verify the connection.

---

### **Step 3: Import a Pre-Built Dashboard**

1. Go to **Dashboards > toggle menu > dashboards > new> Import** in Grafana.

![](/grafana-prebuild.jpg)


1. Enter a **Dashboard ID**:
   - NGINX Dashboard: `9614`
   - Prometheus 2.0 Stats: `3662`
2. Click **Load**.
3. Select your Prometheus data source and click **Import**.


---
#### Screenshot of Prometheus:

##### Screenshot 1:


![](/grafana-prmo1.jpg)

##### Screenshot 2:

![](/grafana-prmo2.jpg)




### **Step 4: Visualize Metrics**

1. Open the imported dashboard.
2. Explore metrics like:
   - Requests per second: `nginx_http_requests_total`.
   - Active connections: `nginx_http_connections`.
3. Customize panels:
   - Add new panels with specific PromQL queries.
   - Adjust time ranges and visualization types (graphs, tables, heatmaps).

---

### **Step 5: Save and Share Dashboards**

1. Save the dashboard for future use:
   - Click the **Save** icon in Grafana.
2. Share the dashboard:
   - Use the **Share** option to generate a link or export the dashboard as JSON.

---

### **Outcome**

- This integration enhances the visibility of your project’s monitoring setup.


- Prometheus monitors your NGINX server serving the Sample E-Commerce Project.

- Metrics like nginx_http_requests_total can be viewed in Prometheus.

- Grafana provides a professional-looking dashboard to visualize NGINX metrics in real time.
