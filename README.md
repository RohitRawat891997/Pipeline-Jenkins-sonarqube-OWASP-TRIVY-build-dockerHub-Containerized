🚀 CI/CD Pipeline Project
<p align="center"> <img src="https://img.shields.io/badge/CI%2FCD-Pipeline-blue?style=for-the-badge&logo=jenkins&logoColor=white" /> <img src="https://img.shields.io/badge/Jenkins-Automation-red?style=for-the-badge&logo=jenkins&logoColor=white" /> <img src="https://img.shields.io/badge/SonarQube-Code%20Quality-blue?style=for-the-badge&logo=sonarqube&logoColor=white" /> <img src="https://img.shields.io/badge/Trivy-Security-orange?style=for-the-badge&logo=aqua&logoColor=white" /> <img src="https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white" /> <img src="https://img.shields.io/badge/MySQL-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white" /> </p>
📖 Overview

A complete CI/CD pipeline for a Laravel application featuring:

✅ Jenkins – CI/CD automation
✅ SonarQube – Code quality analysis
✅ Trivy – Security scanning
✅ Docker Compose – Containerized deployment
✅ MySQL – Database backend

🛠️ Tech Stack
<p align="center"> <img src="https://skillicons.dev/icons?i=php,laravel,mysql,jenkins,docker,sonarqube,github,linux" /> </p>
⚙️ Setup Guide
🔹 Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-compose-plugin

🔹 Install Trivy
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main \
 | sudo tee /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install -y trivy

🔹 Run SonarQube
docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community


👉 Access: http://localhost:9000

🔹 Install Jenkins
sudo apt install -y openjdk-21-jre
sudo apt install -y jenkins


👉 Access: http://localhost:8080

🏗️ Jenkins Pipeline
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

📊 Reports

SonarQube Dashboard – Code quality & bugs

Trivy Report – Vulnerabilities (trivy-fs-report.html)

Jenkins UI – Pipeline execution

🌍 Access Points

Laravel App: http://localhost

SonarQube: http://localhost:9000

Jenkins: http://localhost:8080

👨‍💻 Author

Rohit Rawat
