#!/usr/bin/env bash
# updating os packages
sudo yum update -y

# setting up jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade

# add required dependencies for the jenkins package
sudo yum install -y java-11-openjdk-devel
sudo yum install -y jenkins

# installing docker
curl -fsSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker jenkins

# enabling and starting docker.service
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins

# installing sonar scanner
echo "Installing Sonar Scanner..."
sudo yum install unzip -y
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip
unzip sonar-scanner-cli-4.6.2.2472-linux.zip -d /opt/
mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner
chown -R jenkins:jenkins /opt/sonar-scanner
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' | sudo tee -a /etc/profile

# installing nodejs
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs -y

# creating docker volume to nexus and setting nexus container up
sudo docker volume create --name snexus-data
sudo docker -d -p 8091:8081 -p 8123:8123 --name nexus --volume nexus-data sonatype/nexus3
