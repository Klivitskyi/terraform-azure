#!/bin/bash
sudo -u testadmin apt update
sudo -u testadmin apt install software-properties-common
sudo -u testadmin add-apt-repository --yes --update ppa:ansible/ansible
sudo -u testadmin apt install ansible



sudo -u testadmin ssh-keygen -b 2048 -t rsa -f /home/testadmin/.ssh/id_rsa -N ""