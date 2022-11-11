##################################
#	Socat Redirector	 #
##################################
resource "aws_instance" "MH-SOCAT-RDR" {
  # ami	= "ami-0c55b159cbfafe1f0"
  ami                    = "ami-03b6c8bd55e00d5ed"
  instance_type          = "t2.micro"
  count                  = var.num_of_instances
  vpc_security_group_ids = [aws_security_group.mh-sec-group.id]
  key_name               = var.ssh-pubkey
#  vpc_id = aws_vpc.mh-vpc.id
  subnet_id = aws_subnet.mh-priv-subnet.id
  private_ip = "172.16.0.${count.index + 5}"
  
  



provisioner "local-exec" {
  command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.ssh-privkey} ansible/setup-socat.yaml -e 'c2=${aws_instance.MH-C2-SERVER.public_ip}'"
}



  tags = {
    Name = "MH-SOCAT-RDR${count.index}"
  }
}



##################################
#    Command & Control Server    #
##################################
resource "aws_instance" "MH-C2-SERVER" {
  ami                    = "ami-03b6c8bd55e00d5ed"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mh-sec-group.id]
  key_name               = var.ssh-pubkey
  subnet_id = aws_subnet.mh-priv-subnet.id
  private_ip = "172.16.0.200"
  tags = {
    Name = "MH-C2-SERVER"
  }
}

#NGINX HTTP Redirector
#TODO


#WireGuard Tunnel
#TODO
