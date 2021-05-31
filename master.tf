variable "ssh-pubkey" {
   description = "Name of public key that is in AWS"
	default = ""
}

variable "ssh-privkey-path" {
   description = "full private key path"
	default = ""
}
variable "c2_server" {
    description = "Location where redirectors will send traffic to"
}
variable "region" {
    description = "Region where to deploy resources to"
}

variable "access_key" {
    description = "Access key for AWS service account"
    default = ""
}

variable "secret_key" {
  description = "Secret key for AWS service account"
  default = ""
}

module "http-redirector" {
   source = "./modules/http-redirector"
   num_of_instances = var.num_of_instances
   c2_server = var.c2_server
   ssh-privkey-path = var.ssh-privkey-path
   ssh-pubkey = var.ssh-pubkey

}

variable "num_of_instances" {
    description = "Number of nodes to spin up"
}
provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.region
}

output "public-ip" {
    description = "IP Addresses of HTTP redirectors"
    value = ["Redirectors located at:", "${module.http-redirector.public-ip}"]
}