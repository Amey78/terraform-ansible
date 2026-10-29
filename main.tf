provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0c7632fb77f35db43"
  instance_type          = "t3.micro"
  key_name               = "june-2026"
  tags = {
    Name = "terraform-ansible-app"
  }
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  provisioner "local-exec" {
    command = "sleep 90 && echo '[webservers]' > inventory.ini && echo '${self.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=june-2026.pem' >> inventory.ini && ansible-playbook -i inventory.ini playbook.yml"
  }
}

resource "aws_security_group" "app_sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "app_url" {
  value = "http://${aws_instance.app_server.public_ip}:3000"
}
