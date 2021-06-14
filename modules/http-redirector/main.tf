# Variables
variable "num_of_instances" {
  description = "Number of nodes to spin up"
}

variable "ssh-pubkey" {
  description = "Name of public key that is in AWS"
  default     = ""
}

variable "ssh-privkey-path" {
  description = "full private key path"
  default     = ""
}

variable "c2_server" {
  description = "Location where redirectors will send traffic to"
}

variable "region" {
  description = "Region where to deploy resources to"
}

variable "access_key" {
  description = "Access key for AWS service account"
  default     = ""
}

variable "secret_key" {
  description = "Secret key for AWS service account"
  default     = ""
}

# AWS Credentials
##############################
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# Firewall Configuration
##############################################################
resource "aws_security_group" "mh-sec-group" {
  name = "mh-sec-group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Services
#######################################################
resource "aws_instance" "MH-HTTP-RDR" {
  # ami	= "ami-0c55b159cbfafe1f0"
  ami                    = "ami-03b6c8bd55e00d5ed"
  instance_type          = "t2.micro"
  count                  = var.num_of_instances
  vpc_security_group_ids = [aws_security_group.mh-sec-group.id]
  key_name               = var.ssh-pubkey
  tags = {
    Name = "MH-HTTP-RDR${count.index}"
  }

  # Setup Commands
  ###############################################################
  provisioner "file" {
    source      = "${path.module}/setup_redirector.sh"
    destination = "/tmp/setup_redirector.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh-privkey-path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup_redirector.sh",
      "/tmp/setup_redirector.sh",
      "echo \"@reboot root socat TCP4-LISTEN:80,fork TCP4:${var.c2_server}:80\" | sudo tee -a /etc/cron.d/mdadm > /dev/null",
      "echo \"@reboot root socat TCP4-LISTEN:443,fork TCP4:${var.c2_server}:443\" | sudo tee -a /etc/cron.d/mdadm > /dev/null",
      "sudo shutdown now -r"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh-privkey-path)
      host        = self.public_ip
    }
  }
}
# Output
###############################################################
output "public-ip" {
  description = "IP Addresses of HTTP redirectors"
  value       = aws_instance.MH-HTTP-RDR.*.public_ip
}
