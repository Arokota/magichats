terraform {
   required_providers {
     aws = {
       source = "hashicorp/aws"
     }
   }
 }

# AWS Credentials
##############################
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# AWS VPC Creation
##############################
resource "aws_vpc" "mh-vpc" {
  cidr_block = "172.16.0.0/24"
  tags = {
	Name = "mh-vpc"
}
}
# AWS Internet Gateway Creation
##############################
# Necessary so we can route in/out on public addresses
resource "aws_internet_gateway" "mh-igw" {

	vpc_id = aws_vpc.mh-vpc.id
	tags = {
		Name = "mh-igw"
}
}



# AWS Subnet Creation
##############################
resource "aws_subnet" "mh-priv-subnet" {

	vpc_id = aws_vpc.mh-vpc.id
	cidr_block = "172.16.0.0/24"
	map_public_ip_on_launch = "1"
tags = {
	Name = "mh-priv-subnet"
}
}


# AWS Routing Table Creation
##############################
#Necessary for the VPC to be publically routable
resource "aws_route_table" "mh-public-rt" {
	vpc_id = aws_vpc.mh-vpc.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.mh-igw.id
	}
}


resource "aws_route_table_association" "public" {

	route_table_id = aws_route_table.mh-public-rt.id
	subnet_id = aws_subnet.mh-priv-subnet.id
}
