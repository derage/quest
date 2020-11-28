#!/bin/sh

# Install docker on amazon linux 2
# Following https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo 'version: "3.3"
services:
  web:
    image: "derage/quest:latest"
    ports:
      - "80:3000"' > docker-compose.yml

docker-compose up -d