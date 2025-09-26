🚀 DevOps CI/CD Pipeline with Jenkins, SonarQube, and Trivy

A complete DevOps CI/CD pipeline setup using Jenkins, SonarQube, Docker, and Trivy for automated code quality analysis, security scanning, and containerized deployment.

📋 Overview

This project sets up a robust CI/CD pipeline that includes:

Jenkins → CI/CD automation server

SonarQube → Code quality & static analysis

Trivy → Vulnerability & security scanning

Docker & Docker Compose → Containerization & deployment

🚀 Prerequisites

✔️ Ubuntu Linux system
✔️ Sudo privileges
✔️ Internet connection

🛠️ Installation Guide
1️⃣ Install Docker
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
