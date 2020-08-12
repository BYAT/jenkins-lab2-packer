#!/bin/bash
sudo apt update -y 
sudo apt install git curl make vim -y
sudo apt install jq -y
curl -L get.docker.com |sh
sudo usermod -aG docker ubuntu
