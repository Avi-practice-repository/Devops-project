#!/bin/bash

set -e

echo "Starting DevOps project deployment..."

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"

echo "Checking AWS connection..."
aws sts get-caller-identity > /dev/null

echo "Checking SSH key..."
if [ ! -f "$HOME/.ssh/devops-project-key.pub" ]; then
    echo "SSH key not found. Creating new SSH key..."
    ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/devops-project-key" -N ""
    chmod 400 "$HOME/.ssh/devops-project-key"
else
    echo "SSH key already exists."
fi

echo "Running Terraform..."
terraform -chdir=terraform init
terraform -chdir=terraform fmt
terraform -chdir=terraform validate
terraform -chdir=terraform apply -auto-approve

EC2_IP=$(terraform -chdir=terraform output -raw ec2_public_ip)

echo "EC2 Public IP: $EC2_IP"

echo "Creating Ansible inventory file..."
cat > ansible/inventory.ini <<EOF
[webserver]
$EC2_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/devops-project-key
EOF

echo "Waiting for EC2 SSH service..."
sleep 20

echo "Testing Ansible connection..."
ANSIBLE_HOST_KEY_CHECKING=False ansible -i ansible/inventory.ini webserver -m ping

echo "Running Ansible playbook..."
cd ansible
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini playbook.yml

echo "Deployment completed successfully!"
echo "Open your website:"
echo "http://$EC2_IP:5000"
echo ""
echo "Health check:"
echo "http://$EC2_IP:5000/health"