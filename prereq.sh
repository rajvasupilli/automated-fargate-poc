#!/bin/bash
# Install Java8
sudo yum install -y java-1.8.0-openjdk.x86_64

# Install wget, git and unzip
sudo yum install -y wget
sudo yum install -y git
sudo yum install -y unzip

# Install AWS CLI version2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install SBT
sudo curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
sudo yum -y install sbt

# Install Docker
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf repolist -v
sudo dnf list docker-ce --showduplicates | sort -r
sudo dnf install -y docker-ce-3:19.03.13-3.el8
sudo systemctl start docker
