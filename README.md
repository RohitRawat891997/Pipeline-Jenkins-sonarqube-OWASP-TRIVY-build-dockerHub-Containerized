DevOps CI/CD Pipeline with Jenkins, SonarQube, and Trivy
A complete DevOps CI/CD pipeline setup using Jenkins, SonarQube, Docker, and Trivy for automated code quality analysis and security scanning.

📋 Overview
This project sets up a robust CI/CD pipeline that includes:

Jenkins - Continuous Integration/Continuous Deployment server

SonarQube - Code quality and static analysis tool

Trivy - Security vulnerability scanner

Docker - Containerization platform

🚀 Prerequisites
Ubuntu Linux system

Sudo privileges

Internet connection

🛠️ Installation Guide
1. Install Docker
bash
# Update system and install dependencies
sudo apt-get update
sudo apt-get install ca-certificates curl

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
2. Install Trivy (Security Scanner)
bash
# Install dependencies
sudo apt-get install wget apt-transport-https gnupg lsb-release

# Add Trivy repository
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list

# Install Trivy
sudo apt-get update
sudo apt-get install trivy -y
3. Install and Configure SonarQube
bash
# Run SonarQube in Docker container
docker run -itd --name sonarqube -p 9000:9000 sonarqube:lts-community
Access SonarQube at: http://your-server-ip:9000

Default credentials: admin/admin

4. Install Java
bash
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y

# Verify installation
java -version
5. Install Jenkins
bash
# Add Jenkins repository key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt update
sudo apt install jenkins -y
Access Jenkins at: http://your-server-ip:8080

⚙️ Configuration
Required Jenkins Plugins
Install the following plugins through Jenkins Plugin Manager:

SonarQube Scanner for Jenkins

Sonar Quality Gates Plugin

Pipeline: Stage View Plugin

System Configuration
Configure Docker permissions for Jenkins:

bash
# Add Jenkins user to docker group
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER

# Restart services
sudo systemctl restart docker
sudo systemctl restart jenkins
Configure sudoers for Jenkins:

bash
# Edit sudoers file
sudo visudo

# Add the following line:
jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose
Configure SonarQube in Jenkins:

Go to Manage Jenkins → System Configuration

Add SonarQube server configuration

Configure SonarQube scanner tools

🏗️ Pipeline Setup
Creating a Jenkins Pipeline
Create a new Pipeline job in Jenkins

Configure pipeline script (Jenkinsfile) from your SCM or directly in Jenkins

Set up webhooks for automatic triggering from your version control system

Sample Pipeline Stages
A typical pipeline includes:

Code checkout

Dependency installation

Unit testing

SonarQube analysis

Trivy security scanning

Build and package

Deployment

🔧 Usage
Starting Services
bash
# Start SonarQube
docker start sonarqube

# Start Jenkins
sudo systemctl start jenkins

# Check status
sudo systemctl status jenkins
docker ps
Accessing Web Interfaces
Jenkins: http://your-server-ip:8080

SonarQube: http://your-server-ip:9000

🧪 Verification
Verify installations:

bash
# Check Docker
docker --version

# Check Trivy
trivy --version

# Check Java
java -version

# Check Jenkins
sudo systemctl status jenkins
🔒 Security Notes
Change default passwords for Jenkins and SonarQube

Configure firewall rules to restrict access to necessary ports

Regularly update all components to latest versions

Monitor logs for security events

🆘 Troubleshooting
Common Issues
Jenkins cannot access Docker:

bash
# Verify group membership
groups jenkins
# Restart services
sudo systemctl restart docker jenkins
SonarQube not accessible:

bash
# Check container status
docker ps
docker logs sonarqube
Port conflicts:

Change port mappings in Docker run commands if needed

📞 Support
For issues related to this setup:

Check service logs: journalctl -u jenkins or docker logs sonarqube

Verify all installation steps were completed successfully

Ensure all prerequisites are met
