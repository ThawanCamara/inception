#!/bin/bash

# Log in as root
apt update && apt upgrade

apt install -y sudo

apt install -y vim

USER=awk -F: '{ print $1 }' /etc/passwd | tail -1

sed -i "47 i $USER\tALL=(ALL:ALL) ALL" /etc/sudoers

# Add main user to sudoers

apt install -y curl

curl -fsSL https://get.docker.com/ | sh
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
