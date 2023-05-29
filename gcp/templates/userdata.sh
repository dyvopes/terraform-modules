#!/bin/bash
set -euo pipefail

sudo apt update
echo "deb https://debian.cassandra.apache.org 41x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -
sudo apt update

apt install net-tools
sudo apt install openjdk-8-jdk -y
sudo apt install cassandra -y

mv /etc/cassandra/cassandra.yaml /etc/cassandra/cassandra.yaml.bak
sudo systemctl enable cassandra
