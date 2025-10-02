#!/bin/bash
# Description: Essential APT installs and service configuration for a fresh Debian/Ubuntu VM.

# Stop the script if any command fails
set -e

echo "Starting essential VM setup on Debian/Ubuntu..."

# --- 1. SYSTEM UPDATE ---
echo "1. Performing system update and upgrading existing packages..."
# apt update fetches new package lists
sudo apt update
# apt upgrade installs new versions of packages you have
sudo apt upgrade -y

# --- 2. INSTALL CORE PACKAGES ---
echo "2. Installing core development and L.A.M.P stack packages..."
# Debian/Ubuntu uses 'apache2' instead of 'httpd' and 'mysql-server' for MariaDB in some versions
sudo apt install -y \
  vim wget curl git make \
  apache2 mariadb-server \
  php php-mysql \
  ansible python3-pip \
  pciutils tmux haproxy \
  policycoreutils-python-utils # This package is DNF-specific, but the equivalent is often installed via dependencies or is not needed.

# --- 3. ENABLE CORE SERVICES ---
echo "3. Enabling and starting core system services..."
# httpd is named apache2 on Debian/Ubuntu
# firewalld is often not default; we'll install/use ufw (Uncomplicated Firewall) instead.
sudo systemctl enable --now apache2
sudo systemctl enable --now mariadb

# Check if UFW (Uncomplicated Firewall) is installed and install it if not
if ! command -v ufw &> /dev/null
then
    echo "UFW not found. Installing UFW..."
    sudo apt install ufw -y
    sudo systemctl enable --now ufw
fi

# --- 4. CONFIGURE FIREWALL (using UFW) ---
echo "4. Configuring UFW rules (ports 80, 443, 6443)..."
# UFW commands are different from firewalld
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 6443/tcp
sudo ufw enable # Ensure the firewall is active

# --- 5. PYTHON DEPENDENCIES ---
echo "5. Installing Python packages for Openshift/Kubernetes..."
# pip3 is the same across distributions
sudo pip3 install openshift kubernetes

echo "--- Setup Script Complete! ---"
echo "Note: Policycoreutils and SELinux commands (semanage) are generally not needed for default Debian/Ubuntu setups."
