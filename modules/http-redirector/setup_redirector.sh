#!/usr/bin/bash
# https://github.com/hashicorp/terraform/issues/1025
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
sudo apt update
sudo apt-get -y install socat
