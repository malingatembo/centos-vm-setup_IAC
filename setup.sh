#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status

echo "Starting essential CentOS VM setup..."

# 1. System Update and Core Packages
echo "Installing core packages and updating system..."
sudo dnf update -y
sudo dnf install -y \
  vim wget curl git make \
  httpd mariadb-server \
  php php-mysqlnd php-fpm \
  ansible-core python3-pip \
  pciutils tmux policycoreutils-python-utils haproxy

# 2. Enable Core Services
echo "Enabling and starting core services..."
sudo systemctl enable --now httpd
sudo systemctl enable --now mariadb
sudo systemctl enable --now firewalld

# 3. Configure Firewall
echo "Configuring firewalld ports (80, 443, 6443)..."
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --add-port=6443/tcp --permanent
sudo firewall-cmd --add-port=443/tcp --permanent
sudo systemctl restart firewalld

# 4. Python Dependencies
echo "Installing Python packages..."
sudo pip3 install openshift kubernetes

echo "Setup Script Complete."
