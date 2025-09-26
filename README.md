# 🚀 DevOps CI/CD Pipeline with Jenkins, SonarQube, and Trivy

A complete **DevOps CI/CD pipeline** setup using **Jenkins, SonarQube, Docker, and Trivy** for automated code quality analysis, security scanning, and containerized deployment.

---

## 📋 Overview

This project sets up a robust CI/CD pipeline that includes:

- **Jenkins** → CI/CD automation server  
- **SonarQube** → Code quality & static analysis  
- **Trivy** → Vulnerability & security scanning  
- **Docker & Docker Compose** → Containerization & deployment  

---

## 🚀 Prerequisites

✔️ Ubuntu Linux system  
✔️ Sudo privileges  
✔️ Internet connection  

---

## 🛠️ Installation Guide

### 1️⃣ Install Docker
```bash
sudo apt-get update
sudo apt-get install ca-certificates curl -y

# Add Docker’s GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
2️⃣ Install Trivy (Security Scanner)
bash
Copy code
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

# Add Trivy repository
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main \
| sudo tee /etc/apt/sources.list.d/trivy.list

# Install Trivy
sudo apt-get update
sudo apt-get install -y trivy
3️⃣ Install & Run SonarQube
bash
Copy code
docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community
👉 Access SonarQube at: http://your-server-ip:9000
Default login: admin / admin

4️⃣ Install Java
bash
Copy code
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre
java -version
5️⃣ Install Jenkins
bash
Copy code
# Add Jenkins repository key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" \
| sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt update
sudo apt install -y jenkins
👉 Access Jenkins at: http://your-server-ip:8080

⚙️ Jenkins Configuration
🔌 Required Plugins
SonarQube Scanner for Jenkins

Sonar Quality Gates Plugin

Pipeline: Stage View Plugin

🔑 Configure Docker Permissions
bash
Copy code
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER

sudo systemctl restart docker
sudo systemctl restart jenkins
Add to sudoers (sudo visudo):

ruby
Copy code
jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose
🔧 Configure SonarQube in Jenkins
Go to Manage Jenkins → System Configuration

Add SonarQube server details

Configure SonarQube scanner tool

🏗️ Pipeline Setup
✅ Jenkinsfile Pipeline Stages
Code Checkout (GitHub SCM)

SonarQube Analysis (Code quality)

Quality Gate Check

Trivy Security Scan

Build & Deploy with Docker Compose

🔧 Usage
Start Services
bash
Copy code
# Start SonarQube
docker start sonarqube

# Start Jenkins
sudo systemctl start jenkins
Check status:

bash
Copy code
sudo systemctl status jenkins
docker ps
Access
Jenkins → http://your-server-ip:8080

SonarQube → http://your-server-ip:9000

🧪 Verification
bash
Copy code
docker --version
trivy --version
java -version
sudo systemctl status jenkins
🔒 Security Notes
Change default credentials (Jenkins / SonarQube)

Apply firewall rules → expose only needed ports

Keep all dependencies updated

Monitor Jenkins & SonarQube logs regularly

🆘 Troubleshooting
❌ Jenkins cannot access Docker

bash
Copy code
groups jenkins
sudo systemctl restart docker jenkins
❌ SonarQube not accessible

bash
Copy code
docker ps
docker logs sonarqube
❌ Port conflicts
Update port mapping in Docker run/compose configs
