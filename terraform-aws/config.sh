#!/bin/bash

#Install Software Packages
yum update -y
amazon-linux-extras install docker -y
yum install git -y

## Installing Jenkins ##
# Add Jenkins Repo
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import a key file from Jenkins-CI to enable installation from the package:
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade -y

# Install Java:
amazon-linux-extras install java-openjdk11 -y

# Install Jenkins:
yum install jenkins -y

# Enable and start the Jenkins service:
systemctl enable jenkins
systemctl start jenkins

# Enable and Start the services
systemctl enable docker
systemctl start docker

# Configure Git
git config --global user.name rdbharti
git config --global user.email ranadurlabh@yahoo.com

# Configure Jenkins
usermod -aG docker jenkins
chmod 777 /var/run/docker.sock