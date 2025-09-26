🚀 CI/CD Pipeline with Jenkins, SonarQube, Trivy & Docker








📖 Overview

This project demonstrates a complete CI/CD pipeline for a Laravel application using:

Jenkins → CI/CD automation

SonarQube → Code quality & static analysis

Trivy → Security vulnerability scanning

Docker & Compose → Containerized deployment

🛠️ Tech Stack

Backend: PHP 8.2 (Laravel-ready)

Database: MySQL 8.0

Tools: Jenkins, SonarQube, Trivy

Infra: Docker, Docker Compose

⚙️ Setup Guide
1️⃣ Install Docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
 https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
 | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

2️⃣ Install Trivy
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main \
 | sudo tee /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install -y trivy

3️⃣ Run SonarQube
docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community


🔗 Access: http://localhost:9000

4️⃣ Install Java (OpenJDK 21)
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre
java -version

5️⃣ Install Jenkins
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
 | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins


🔗 Access: http://localhost:8080

🔧 Jenkins Configuration

Install Plugins:
✅ SonarQube Scanner
✅ Sonar Quality Gates
✅ Pipeline: Stage View

Add Jenkins to Docker group:

sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER
sudo systemctl restart docker jenkins


Update sudoers:

jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose

🏗️ Pipeline (Jenkinsfile)
pipeline {
    agent any
    environment {
        SONAR_HOME = tool "Sonar"
    }
    stages {
        stage("Clone Repo") {
            steps {
                git url: "https://github.com/RohitRawat891997/Pipeline-Jenkins-sonarqube-OWASP-TRIVY-build-dockerHub-Containerized.git", branch: "main"
            }
        }
        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv("Sonar") {
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=wanderlust -Dsonar.projectKey=wanderlust"
                }
            }
        }
        stage("Quality Gate") {
            steps {
                timeout(time: 2, unit: "MINUTES") {
                    waitForQualityGate abortPipeline: false
                }
            }
        }
        stage("Trivy Security Scan") {
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html ."
            }
        }
        stage("Deploy with Docker Compose") {
            steps {
                sh "docker compose up --build -d"
            }
        }
    }
}

🐳 Docker Setup

Dockerfile Highlights

PHP 8.2 + Apache

Composer + Node.js

Configured for Laravel

docker-compose.yml Highlights

app → Laravel application container

mysql → MySQL 8.0 with persistent volume

📊 Reports

SonarQube → Code quality dashboard

Trivy → Vulnerability report (trivy-fs-report.html)

Jenkins → Pipeline execution & build results

🌍 Access Points

Laravel App: http://localhost

SonarQube: http://localhost:9000

Jenkins: http://localhost:8080

👨‍💻 Author

Rohit Rawat
