# CI/CD Pipeline with Jenkins, SonarQube, Trivy & Docker

![Jenkins](https://img.shields.io/badge/Jenkins-Automation-red?logo=jenkins&logoColor=white)
![SonarQube](https://img.shields.io/badge/SonarQube-Code%20Quality-blue?logo=sonarqube&logoColor=white)
![Trivy](https://img.shields.io/badge/Trivy-Security%20Scanner-orange?logo=aqua&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containerized-blue?logo=docker&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-8.2-777bb4?logo=php&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)

---

This project demonstrates how to set up a complete CI/CD pipeline using **Jenkins**, **SonarQube**, **Trivy**, and **Docker**.  
It automates **code analysis**, **security scanning**, and **deployment of a containerized Laravel application**.

---

## 🚀 Features
- SonarQube integration for static code analysis
- Trivy for container and filesystem vulnerability scanning
- Docker & Docker Compose for containerized deployment
- Jenkins pipeline automation
- Laravel application running inside PHP-Apache container with MySQL backend

---

## 🛠️ Prerequisites
Ensure your system has the following installed:

- **Ubuntu 20.04+ / Debian-based system**
- **Docker & Docker Compose**
- **Java (OpenJDK 21)**
- **Jenkins**
- **Trivy**
- **SonarQube**

---

## ⚙️ Installation Steps

### 1. Install Docker
```bash
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
bash
Copy code
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install -y trivy
3. Install and Run SonarQube
bash
Copy code
docker run -itd --name sonarqube -p 9000:9000 sonarqube:lts-community
Access SonarQube at: http://localhost:9000

4. Install Java (OpenJDK 21)
bash
Copy code
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre
java -version
5. Install Jenkins
bash
Copy code
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

Configure Sonar Scanner tool in Jenkins (Manage Jenkins → Global Tool Configuration)

7. Permissions & Docker Access
bash
Copy code
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER

sudo systemctl restart docker
sudo systemctl restart jenkins
Update sudoers file:

bash
Copy code
sudo visudo
Add:

ruby
Copy code
jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose
🏗️ Jenkins Pipeline
Use the following Jenkins pipeline (Jenkinsfile style):

groovy
Copy code
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
Defines two services:

app → Laravel application (PHP + Apache)

mysql → MySQL 8.0 database with persistent volume

📂 Project Structure
css
Copy code
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
