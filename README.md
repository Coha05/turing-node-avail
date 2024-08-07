# turing-node-avail
## Guide how to install Turing Avail Node using systemctl

## Auto Install
```
source <(curl -s https://raw.githubusercontent.com/Coha05/turing-node-avail/main/avail-turing-auto.sh)
```
### Update apt & install package dependencies
```
sudo apt update && sudo apt upgrade -y
```
### Create a new directory named "avail"
```
mkdir avail
cd avail
```
### Download the binary and extract that
```
# Fetch the latest release URL from GitHub API
LATEST_URL=$(curl -s https://api.github.com/repos/availproject/avail/releases/latest | grep browser_download_url | grep x86_64-ubuntu-2204-avail-node.tar.gz | cut -d '"' -f 4)

# Download the latest release
wget $LATEST_URL

# Extract the binary
tar -xf x86_64-ubuntu-2204-avail-node.tar.gz 

# Delete the zip tar file
rm x86_64-ubuntu-2204-avail-node.tar.gz
```
### Create a directory for node data
```
mkdir node-data
```
### Create the service unit file
```
sudo nano /etc/systemd/system/avail.service
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
sudo systemctl daemon-reload
sudo systemctl start avail
sudo systemctl enable avail
```
### Check the status of the Avail Node service
```
sudo systemctl status avail
```
Check log: 
```
sudo journalctl -u avail.service
```
---

## How to upgrade node

### Go to avail folder and remove the avail node file

```
cd avail
rm -rf avail-node
rm -rf x86_64-ubuntu-2204-avail-node.tar.gz
```
### Download new version and unzip

```
# Fetch the latest release URL from GitHub API
LATEST_URL=$(curl -s https://api.github.com/repos/availproject/avail/releases/latest | grep browser_download_url | grep x86_64-ubuntu-2204-avail-node.tar.gz | cut -d '"' -f 4)

# Download the latest release
wget $LATEST_URL

# Extract the binary
tar -xf x86_64-ubuntu-2204-avail-node.tar.gz 

# Delete the zip tar file
rm x86_64-ubuntu-2204-avail-node.tar.gz
```

### Restart your node

```
sudo systemctl restart avail.service
sudo journalctl -f -u avail.service
```
---
## How to connect your node and get into waiting list


### Bond Your Funds

1. Start staking on the Staking page: https://temp-explorer.avail.so/#/staking/actions.
2. Click the `Stash` button to begin bonding.
![Stash](./Stake-step1.png) 
3. Enter your bonding preferences in the form. Then click `Bond` and `Sign and Submit`
![Bond](Bond-step-1.png)

**You need at least 100,000 AVL to join waiting list.**

### Get your Session Keys

Run the following command on your node:
```
curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "author_rotateKeys", "params":[]}' http://localhost:9944
```

Example result:
![Result](result-key.PNG)

### Submit Session Keys

1. Go to [Staking Tab](https://goldberg.avail.tools/#/staking/actions) again
2. Click on Set `Session Key` and enter the hex-encoded result.
3. Click Set `Session Key` and enter your password when prompted.
![Enter-key](set-session-keys.png)

### Register as a Validator

1. Click `Validate` on the Staking tab.
![Validate](start-validating.png)
2. Set your validator commission percentage.
3. Enter your password and click `Validate`.
![Validate](set-validate-commission.png)


### Congrats you've made it done

 Check your validator status `Waiting` or `Active` on the `Staking` page [here](https://temp-explorer.avail.so/#/staking)

 ![node-status](check-node-status.png)

 ---
