#!/bin/bash

# Punch a hole in the firewall
sudo iptables -A INPUT -p tcp -s 10.10.0.0/16 --dport ssh -j ACCEPT

# Enable TCP forwarding to access local DEV sites
sudo sed -i -e 's/^AllowTcpForwarding\ no//g' /etc/ssh/sshd_config
sudo systemctl restart ssh
