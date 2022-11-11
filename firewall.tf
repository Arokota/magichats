# Firewall Configuration
##############################################################
resource "aws_security_group" "mh-sec-group" {
  name = "mh-sec-group"
  vpc_id = aws_vpc.mh-vpc.id
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
