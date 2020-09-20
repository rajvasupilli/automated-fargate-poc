#!/bin/bash

# git clone git@github.com:rajvasupilli/automated-fargate-poc.git
# Install Java8
sudo yum install -y java-1.8.0-openjdk.x86_64

# Install wget, git and unzip
sudo yum install -y wget
sudo yum install -y git
sudo yum install -y unzip

# Install SBT
sudo curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
sudo yum -y install sbt

# Install Docker
sudo dnf config-manager --add-
repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf repolist -v
sudo dnf list docker-ce --showduplicates | sort -r
sudo dnf install docker-ce-3:18.09.1-3.el7
sudo systemctl start docker

# 
