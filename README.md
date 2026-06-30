# DevOps Grocery Store Project

## Project Overview

This is a simple DevOps project where a Grocery Store web application is deployed on AWS EC2 using Docker, Terraform, Ansible, Linux, Python Flask, and Git.

## Application Name

FreshMart Grocery Store

## Tools Used

- Python Flask for web application
- HTML and CSS for frontend design
- Docker for containerization
- Terraform for AWS infrastructure creation
- Ansible for server configuration and deployment
- AWS EC2 for hosting
- Git for version control
- Linux as server environment

## Project Flow

1. Created a simple Grocery Store website using Python Flask, HTML, and CSS.
2. Created a Dockerfile to containerize the application.
3. Tested the Docker container locally.
4. Used Terraform to create AWS EC2 instance, security group, and key pair.
5. Used Ansible to connect to the EC2 server.
6. Installed Docker on EC2 using Ansible.
7. Copied project files to EC2.
8. Built Docker image on EC2.
9. Ran the application container on EC2.
10. Accessed the website using EC2 public IP.

## Application URL


http://EC2_PUBLIC_IP:5000