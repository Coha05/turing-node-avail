# turing-node-avail
## Guide how to install Turing Avail Node using systemctl

### Update apt & install package dependencies
```
sudo apt update && sudo apt upgrade -y
```
### Create a new directory named "avail"
```
mkdir avail
```
### Download the binary
```
wget https://github.com/availproject/avail/releases/download/v2.0.0.0-rc4/x86_64-ubuntu-2204-avail-node.tar.gz -P avail
```

### Extract the binary
```
tar -xf /root/avail/x86_64-ubuntu-2204-avail-node.tar.gz -C avail
```
