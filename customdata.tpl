#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y \
sudo apt install unzip -y
sudo apt install jq -y
wget https://github.com/kubernetes/kops/releases/download/v1.21.1/kops-linux-amd64
mv kops-linux-arm64 kops
chmod 777 kops
mv kops /usr/local/bin/