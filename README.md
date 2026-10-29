# Assignment 2 - Terraform and Ansible

I used Terraform to create an AWS EC2 (Ubuntu) server and a security group, then run my Ansible playbook on it automatically.

## Files
- main.tf: creates the EC2 and security group, then runs Ansible
- playbook.yml: installs Node.js, clones the repo, starts the app
- inventory.ini: made by Terraform with the new server IP
