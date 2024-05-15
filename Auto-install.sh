#!/bin/bash

# Prompt the user for their node name
read -p "Enter your node name: " NODE_NAME

# Update apt & install package dependencies
sudo apt update && sudo apt upgrade -y

# Create a new directory named "avail"
mkdir -p ~/avail
cd ~/avail

# Download the binary
wget https://github.com/availproject/avail/releases/download/v2.2.0.0-rc1/x86_64-ubuntu-2204-avail-node.tar.gz

# Extract the binary
tar -xf x86_64-ubuntu-2204-avail-node.tar.gz 

# Create a directory for node data
mkdir -p ~/avail/node-data

# Create the service unit file
sudo tee /etc/systemd/system/avail.service > /dev/null <<EOF
[Unit]
Description=Avail Node

[Service]
Type=simple
ExecStart=/root/avail/avail-node --chain turing --name $NODE_NAME --validator -d /avail/node-data
Restart=always
RestartSec=3
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=avail-node

[Install]
WantedBy=multi-user.target
EOF

# Reload systemctl and start the Avail Node service
sudo systemctl daemon-reload
sudo systemctl start avail.service
sudo systemctl enable avail.service

# Check the status of the Avail Node service
sudo systemctl status avail.service

# Provide instructions to check the logs
echo "To check the logs, use the following command:"
echo "journalctl -u avail.service"
