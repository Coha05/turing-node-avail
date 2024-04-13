# turing-node-avail
## Guide how to install Turing Avail Node using systemctl

### Update apt & install package dependencies
```
sudo apt update && sudo apt upgrade -y
```
### Create a new directory named "avail"
```
mkdir avail
cd avail
```
### Download the binary
```
wget https://github.com/availproject/avail/releases/download/v2.0.0.0-rc4/x86_64-ubuntu-2204-avail-node.tar.gz -P avail
```

### Extract the binary
```
tar -xf /root/avail/x86_64-ubuntu-2204-avail-node.tar.gz -C avail
```

### Create a directory for node data
```
mkdir node-data
```
### Create the service unit file
```
nano /etc/systemd/system/avail.service
```
### Add the following content to the avail-turing.service file
```
[Unit]
Description=Avail Node

[Service]
Type=simple
ExecStart=/root/avail/avail-node --chain turing --name {your-name-here} --validator -d /avail/node-data
Restart=always
RestartSec=3
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=avail-node

[Install]
WantedBy=multi-user.target

```
### Save and close the file

In nano, you can do this by pressing Ctrl + X, then Y to confirm, and finally Enter to save.

### Reload systemctl and Start the Avail Node service:
```
systemctl daemon-reload
systemctl start avail-node
systemctl enable avail-node
```
### Check the status of the Avail Node service
```
systemctl status avail-node
```
Check log: 
```
journalctl -u avail.service
```
or
```
journalctl -u avail.service
```