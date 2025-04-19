
# 🐍 Web Scraper Flask App with Docker on AWS EC2

This guide walks you through launching an EC2 instance on AWS, setting up Docker, and running a Flask-based web scraper app from a GitHub repository.

---

## 📌 Step 1: Launch EC2 Instance on AWS

1. **Log in** to [AWS Management Console](https://aws.amazon.com/console/).
2. Navigate to **EC2 Dashboard**.
3. Click **Launch Instance**.
4. Configure the following:
   - **Name**: `web-scraper-flask-docker`
   - **AMI**: Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
   - **Instance Type**: `t2.micro` (Free Tier eligible)

5. Proceed to **Configure Security Group**:
   - Create a new security group or use an existing one.
   - Allow the following inbound rules:
     - **SSH** – Port 22
     - **HTTP** – Port 80 *(Optional)*
     - **Custom TCP** – Port 5000 (For Flask App)

6. Click **Launch Instance**.

---

## 🔗 Step 2: Connect to Your EC2 Instance

Use SSH to connect to your EC2 instance:

```bash
ssh -i "my-Key-pair.pem" ec2-user@ec2-54-227-172-202.compute-1.amazonaws.com
```

---

## 🐳 Step 3: Install Docker

Run the following commands on your EC2 instance:

```bash
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
```

**Log out and log back in** or run `newgrp docker` to activate group changes.

---

## 🔎 Step 4: Verify Docker Installation

```bash
docker --version
```

You should see Docker's version output.

---

## 📁 Step 5: Set Up Your Project on EC2 Instance

Clone your GitHub repository and navigate to the project folder:

```bash
sudo yum install git -y
git clone https://github.com/arumullayaswanth/web-scraper-flask-docker.git
cd web-scraper-flask-docker
ls
```

---

## 🏗️ Step 6: Build Docker Image

Option 1: Build normally

```bash
docker build -t scraper-flask .
```

Option 2: Pass a custom URL during build

```bash
docker build -t scraper-flask --build-arg SCRAPE_URL="https://portfolioyaswanth.netlify.app/" .
```

---

## 🚀 Step 7: Run Docker Container

```bash
docker run -p 5000:5000 scraper-flask
```


---

## 🌐 Step 8: Access Flask Web App in Browser

Open your browser and go to:

```
http://54.227.172.202:5000
```



## ✅ Notes

- Make sure **port 5000** is open in your EC2 Security Group.
- You can update the URL being scraped by modifying `scrape.js` or passing the URL via environment variable.

---

Made with ❤️ by Arumulla Yaswanth Reddy
