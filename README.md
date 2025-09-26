This project demonstrates how to set up a complete CI/CD pipeline using Jenkins, SonarQube, Trivy, and Docker.
It automates code analysis, security scanning, and deployment of a containerized Laravel application.

🚀 Features

SonarQube integration for static code analysis

Trivy for container and filesystem vulnerability scanning

Docker & Docker Compose for containerized deployment

Jenkins pipeline automation

Laravel application running inside PHP-Apache container with MySQL backend

🛠️ Prerequisites

Ubuntu 20.04+ / Debian-based system

Docker & Docker Compose

Java (OpenJDK 21)

Jenkins

Trivy

SonarQube

⚙️ Installation Steps
1. Install Docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

2. Install Trivy
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install -y trivy

3. Install and Run SonarQube
docker run -itd --name sonarqube -p 9000:9000 sonarqube:lts-community


➡ Access SonarQube: http://localhost:9000

4. Install Java (OpenJDK 21)
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre
java -version

5. Install Jenkins
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins

6. Configure Jenkins

Install Plugins:

SonarQube Scanner for Jenkins

Sonar Quality Gates Plugin

Pipeline: Stage View Plugin

Configure SonarQube in Jenkins (Manage Jenkins → Configure System)

Configure Sonar Scanner tool (Manage Jenkins → Global Tool Configuration)

7. Permissions & Docker Access
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER

sudo systemctl restart docker
sudo systemctl restart jenkins


Update sudoers file:

sudo visudo


Add:

jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose

🏗️ Jenkins Pipeline
pipeline {
    agent any
    environment {
        SONAR_HOME = tool "Sonar"
    }
    stages {
        stage("Clone Code from GitHub") {
            steps {
                git url: "https://github.com/RohitRawat891997/Pipeline-Jenkins-sonarqube-OWASP-TRIVY-build-dockerHub-Containerized.git", branch: "main"
            }
        }
        stage("SonarQube Quality Analysis") {
            steps {
                withSonarQubeEnv("Sonar") {
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=wanderlust -Dsonar.projectKey=wanderlust"
                }
            }
        }
        stage("Sonar Quality Gate Scan") {
            steps {
                timeout(time: 2, unit: "MINUTES") {
                    waitForQualityGate abortPipeline: false
                }
            }
        }
        stage("Trivy File System Scan") {
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html ."
            }
        }
        stage("Deploy using Docker Compose") {
            steps {
                sh "docker compose up --build -d"
            }
        }
    }
}

🐳 Docker Setup
Dockerfile

Uses PHP 8.2 with Apache

Installs Composer, Node.js, Laravel dependencies

Configures Apache for Laravel

docker-compose.yml

app → Laravel application (PHP + Apache)

mysql → MySQL 8.0 database with persistent volume

📂 Project Structure
├── Dockerfile
├── docker-compose.yml
├── laravel.conf
├── Jenkinsfile (inside Jenkins pipeline)
├── src/ (Laravel application code)

📊 Reports

SonarQube → Code Quality Dashboard

Trivy → Vulnerability reports (trivy-fs-report.html)

Jenkins → Build & Pipeline Visualization

🌐 Access

Laravel App → http://localhost:80

SonarQube → http://localhost:9000

Jenkins → http://localhost:8080

✅ Summary

This project sets up a CI/CD pipeline where:

Code is cloned from GitHub

Analyzed using SonarQube

Scanned for vulnerabilities using Trivy

Deployed with Docker Compose

👨‍💻 Author: Rohit Rawat
