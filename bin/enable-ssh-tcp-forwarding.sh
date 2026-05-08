#!/bin/bash

# Enable TCP forwarding to access local DEV sites
sudo sed -i -e 's/^AllowTcpForwarding\ no//g' /etc/ssh/sshd_config
sudo systemctl restart ssh
sudo ufw allow 22/tcp
sudo ufw allow 8088/tcp
