DevOps CI/CD Setup with Docker, Trivy, SonarQube, and Jenkins

This project demonstrates a complete setup for a CI/CD pipeline on Ubuntu using Docker, Trivy, SonarQube, and Jenkins. The setup includes installation, configuration, and integration steps to run pipelines with security scanning and code quality analysis.

Prerequisites

Ubuntu 22.04 or later

sudo privileges

1. Install Docker
# Update system and install prerequisites
sudo apt-get update
sudo apt-get install ca-certificates curl -y

# Add Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

2. Install Trivy (Vulnerability Scanner)
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | \
sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y

3. Install and Configure SonarQube
docker run -itd --name sonarqube -p 9000:9000 sonarqube:lts-community


Access SonarQube at: http://localhost:9000

Default login credentials: admin / admin

4. Install Java
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y
java -version


Expected output:

openjdk version "21.0.3" 2024-04-16
OpenJDK Runtime Environment (build 21.0.3+11-Debian-2)
OpenJDK 64-Bit Server VM (build 21.0.3+11-Debian-2, mixed mode, sharing)

5. Install Jenkins
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y

6. Install Jenkins Plugins

Install the following plugins via Jenkins Dashboard → Manage Jenkins → Manage Plugins:

SonarQube Scanner for Jenkins

Sonar Quality Gates Plugin

Pipeline: Stage View Plugin

7. Configure Jenkins Tools for SonarQube

Configure SonarQube servers under Jenkins → Manage Jenkins → Configure System.

Set SonarQube Scanner path in Jenkins → Global Tool Configuration.

8. Set Permissions
# Add Jenkins user and current user to Docker group
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER

# Restart services
sudo systemctl restart docker
sudo systemctl restart jenkins

9. Configure sudoers for Jenkins
sudo visudo
# Add the following line:
jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose

10. Create and Run Pipeline

Create a Jenkins pipeline using either Declarative or Scripted syntax.

Integrate SonarQube and Trivy for automated quality checks and vulnerability scanning.

Run your pipeline and monitor stages via Jenkins dashboard.

References

Docker Installation Docs

Trivy Docs

SonarQube Docs

Jenkins Docs

✅ Your system is now ready for CI/CD with Docker, Jenkins, SonarQube, and Trivy.
