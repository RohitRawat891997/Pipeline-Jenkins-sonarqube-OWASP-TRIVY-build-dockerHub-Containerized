# CI/CD Pipeline Setup with Docker, Jenkins, SonarQube & Trivy

This project demonstrates setting up a full CI/CD environment on Ubuntu using Docker, Jenkins, SonarQube, and Trivy for automated build, code quality checks, and vulnerability scanning.

🚀 Prerequisites

Ubuntu 22.04+

sudo privileges

1️⃣ Install Docker
```
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

# 2️⃣ Install Trivy (Vulnerability Scanner)
```
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y
```

# 3️⃣ Install and Configure SonarQube
```
docker run -itd --name sonarqube -p 9000:9000 sonarqube:lts-community
```

Access: http://localhost:9000

Default credentials: admin / admin

# 4️⃣ Install Java
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y
java -version


Expected output:

openjdk version "21.0.3"
OpenJDK Runtime Environment (build 21.0.3+11-Debian-2)
OpenJDK 64-Bit Server VM (build 21.0.3+11-Debian-2, mixed mode)

# 5️⃣ Install Jenkins
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install jenkins -y

# 6️⃣ Jenkins Plugins to Install

SonarQube Scanner for Jenkins

Sonar Quality Gates Plugin

Pipeline: Stage View Plugin

# 7️⃣ Configure Jenkins & SonarQube

Configure SonarQube server in Jenkins → Manage Jenkins → Configure System

Add SonarQube Scanner path in Jenkins → Global Tool Configuration

# 8️⃣ Set Permissions
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER
sudo systemctl restart docker
sudo systemctl restart jenkins

# 9️⃣ Configure Sudoers for Jenkins
sudo visudo
# Add:
jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose

🔧 Create & Run Pipeline

Create a Jenkins pipeline (Declarative or Scripted)

Integrate SonarQube and Trivy for code quality and vulnerability scans

Run the pipeline and monitor stages in Jenkins dashboard

# ✅ References

Docker Docs

Trivy Docs

SonarQube Docs

Jenkins Docs
