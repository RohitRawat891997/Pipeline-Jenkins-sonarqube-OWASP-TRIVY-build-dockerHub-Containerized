# CI/CD Pipeline Setup with Docker, Jenkins, SonarQube & Trivy

This project demonstrates setting up a full CI/CD environment on Ubuntu using Docker, Jenkins, SonarQube, and Trivy for automated build, code quality checks, and vulnerability scanning.


# 🚀 Prerequisites
```
Ubuntu 22.04+
instance_type = t2.large 
Storage = 30 GB
sudo privileges
```
# 1️⃣ Install Docker
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

#### Default credentials: admin / admin

# 4️⃣ Install Java
```
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y
java -version
```

#### Expected output:
```
openjdk version "21.0.3"
OpenJDK Runtime Environment (build 21.0.3+11-Debian-2)
OpenJDK 64-Bit Server VM (build 21.0.3+11-Debian-2, mixed mode)
```

# 5️⃣ Install Jenkins
```
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install jenkins -y
```

# 6️⃣ Jenkins Plugins to Install
```
SonarQube Scanner for Jenkins

Sonar Quality Gates Plugin

Pipeline: Stage View Plugin

OWASP Dependency-Check
```
<img width="733" height="367" alt="image" src="https://github.com/user-attachments/assets/35c443af-8c41-42f5-bd90-c50075f885d4" />


# 7️⃣ Configure Jenkins & SonarQube
#
- <b id="Owasp">Configure OWASP, move to <mark>Manage Jenkins --> Plugins --> Available plugins</mark> (Jenkins Worker)</b>
![image](https://github.com/user-attachments/assets/da6a26d3-f742-4ea8-86b7-107b1650a7c2)

- <b id="Sonar">After OWASP plugin is installed, Now move to <mark>Manage jenkins --> Tools</mark> (Jenkins Worker)</b>
![image](https://github.com/user-attachments/assets/3b8c3f20-202e-4864-b3b6-b48d7a604ee8)
#
- <b>Login to SonarQube server and create the credentials for jenkins to integrate with SonarQube</b>
  - Navigate to <mark>Administration --> Security --> Users --> Token</mark>
  ![image](https://github.com/user-attachments/assets/86ad8284-5da6-4048-91fe-ac20c8e4514a)
  ![image](https://github.com/user-attachments/assets/6bc671a5-c122-45c0-b1f0-f29999bbf751)
  ![image](https://github.com/user-attachments/assets/e748643a-e037-4d4c-a9be-944995979c60)

#
### Add SonarQube Scanner path in Jenkins → Global Tool Configuration
<img width="836" height="323" alt="image" src="https://github.com/user-attachments/assets/19dd6db7-b06d-4fba-be68-0a0afb6ab66d" />

### Configure SonarQube server in Jenkins → Manage Jenkins → Configure System
<img width="776" height="469" alt="image" src="https://github.com/user-attachments/assets/a593d736-a9df-48ff-a3d7-df8f60159854" />

<img width="863" height="434" alt="image" src="https://github.com/user-attachments/assets/c506d5e6-8c95-4f08-aaa5-8514be112928" />



# 8️⃣ Set Permissions
```
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER
sudo systemctl restart docker
sudo systemctl restart jenkins
```

# 9️⃣ Configure Sudoers for Jenkins
```
sudo visudo
```
#### Add:
```
jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose
```

# 🔧 Create & Run Pipeline

#### Create a Jenkins pipeline (Declarative or Scripted)

#### Integrate SonarQube and Trivy for code quality and vulnerability scans

#### Run the pipeline and monitor stages in Jenkins dashboard

```
pipeline{
    agent any
    environment{
        SONAR_HOME= tool "Sonar"
    }
    stages{
        stage("Clone Code from GitHub"){
            steps{
                git url: "https://github.com/RohitRawat891997/Pipeline-Jenkins-sonarqube-OWASP-TRIVY-build-dockerHub-Containerized.git", branch: "main"
            }
        }
        stage("SonarQube Quality Analysis"){
            steps{
                withSonarQubeEnv("Sonar"){
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=wanderlust -Dsonar.projectKey=wanderlust"
                }
            }
        }
        
        stage("Sonar Quality Gate Scan"){
            steps{
                timeout(time: 2, unit: "MINUTES"){
                    waitForQualityGate abortPipeline: false
                }
            }
        }
pipeline{
    agent any
    environment{
        SONAR_HOME= tool "Sonar"
    }
    stages{
        stage("Clone Code from GitHub"){
            steps{
                git url: "https://github.com/RohitRawat891997/Pipeline-Jenkins-sonarqube-OWASP-TRIVY-build-dockerHub-Containerized.git", branch: "main"
            }
        }
        stage("SonarQube Quality Analysis"){
            steps{
                withSonarQubeEnv("Sonar"){
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=wanderlust -Dsonar.projectKey=wanderlust"
                }
            }
        }
        
        stage("Sonar Quality Gate Scan"){
            steps{
                timeout(time: 2, unit: "MINUTES"){
                    waitForQualityGate abortPipeline: false
                }
            }
        }
        stage("OWASP Dependency Check"){
            steps{
                dependencyCheck additionalArguments: '--scan ./', odcInstallation: 'OWASP'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage("Trivy File System Scan"){
            steps{
                sh "trivy fs --format  table -o trivy-fs-report.html ."
            }
        }
        stage("Deploy using Docker compose"){
            steps{
                sh "docker compose up --build"
            }
        }
    }
}
        stage("Trivy File System Scan"){
            steps{
                sh "trivy fs --format  table -o trivy-fs-report.html ."
            }
        }
        stage("Deploy using Docker compose"){
            steps{
                sh "docker compose up --build"
            }
        }
    }
}
```

# 📊 CI/CD Workflow
```
   +------------------+
   |   Source Code     |
   +------------------+
            |
            v
   +------------------+
   |   Jenkins CI/CD   |
   |   (Build & Test)  |
   +------------------+
            |
     +------+------+
     |             |
     v             v
+----------+   +---------+
| SonarQube |   |  Trivy |
| Code QC   |   | Scan   |
+----------+   +---------+
     \             /
      \           /
       v         v
    +------------------+
    |   Docker Images   |
    | / Deployment      |
    +------------------+

```
