#!/bin/bash
sudo apt update -y
sudo apt install -y wget gnupg2 software-properties-common

# Install Java 17
wget -qO - https://repos.azul.com/azul-repo.key | gpg --dearmor | sudo tee /usr/share/keyrings/azul.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/azul.gpg] http://repos.azul.com/zulu/deb stable main" | sudo tee /etc/apt/sources.list.d/zulu.list > /dev/null
sudo apt update -y
sudo apt install -y zulu17-jdk

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install -y jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins