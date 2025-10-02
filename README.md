# centos-vm-setup_IAC
Contains initial setup for my centos virtual machines

on target machine, run: 
sudo dnf install git -y
git clone git@github.com-mali:malingatembo/centos-vm-setup_IAC.git
cd centos-vm-setup_IAC

# This uses sudo to run the script with root privileges
sudo ./setup.sh

OR 

# This explicitly calls bash to execute the script
sudo bash setup.sh
