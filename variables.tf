# Variables
########################################################
variable "socat_instances" {
  description = "Number of MH-SOCAT-RDR to spin up"
}

variable "apache_instances" {
  description = "Number of MH-APACHE-RDR to spin up"
}

variable "ssh-pubkey" {
  description = "Name of public key that is in AWS"
  default     = "mh.pub"
}

variable "ssh-privkey" {
  description = "full private key path"
  default     = "mh.pem"
}

#variable "c2_server" {
#  description = "Location where redirectors will send traffic to"
#}

variable "region" {
  description = "Region where to deploy resources to"
  default     = "us-east-2"
}

variable "access_key" {
  description = "Access key for AWS service account"
  default     = ""
}

variable "secret_key" {
  description = "Secret key for AWS service account"
  default     = ""
}

variable "redirector-type" {
  description = "Socat or Apache (requires ansible config)"
  default = "socat"
}

