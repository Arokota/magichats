# MagicHats 
![MagicalHats](magicalhats.png)
## Description
Penetration tests often require a lot of repeat work that can be easily automated.  Multiple solutions for infrasture as code (IaC) exist such as Terraform and Ansible.  By wrapping common options in a bash script I hope to add a bit of modularity for different deployment scenarios.

Current state of deployment does not utilize `mh.sh` and relies on Terraform configurations.  This is a temporary solution.

## Capabilities
- [x] Automatic AWS VPC Creation
- [x] Automatic AWS Subnet Creation
- [x] Automatic AWS Firewall Rule Creation
- [x] Socat Redirectors
- [ ] NGINX HTTP Redirectors
	- [ ] Automate LetsEncrypt Registration
- [x] C2 Server Deployment
	- [ ] Sliver
	- [ ] CobaltStrike
	- [ ] Wireguard Bastion (RedRoute)
## Installation

```
apt install terraform
terraform init #installs hashicorp/aws for you
apt install ansible
```
Ansible requires Python3 to run so if you don't have that installed I believe it will pull it down for you.

```
git clone https://github.com/arokota/magichats
cd magichats
vi terraform.tfvars
```
Edit `terraform.tfvars` and fill in your AWS credentials and SSH keys

## Example Usage

`terraform apply`

![RT-Diagram](rt-infra-diagram.png)

## Future Work
* Modify primary workflow to work as follows:
	* Run `mh.sh` and answer prompts for what you want to deploy
	* Answers written to variables in a .tfvars file
	* Terraform launched with the `--var-file="variables.tfvars" file
	* Profit

## Inspiration

A lot of these folk wrote really great blog posts that I definitely totally did not lift a couple of snippets here and there from.  Overall I think it's a great excercise to build this out yourself rather than just using someone elses deployment scripts. *Shakes fisk at Ansible*

- https://rastamouse.me/infrastructure-as-code-terraform-ansible/
- https://anubissec.github.io/Using-Ansible-and-Terraform-to-Build-Red-Team-Infrastructure/
- https://www.ired.team/offensive-security/red-team-infrastructure/automating-red-team-infrastructure-with-terraform
- https://github.com/tevora-threat/rt_redirectors
- Image Credit: https://www.deviantart.com/d4nt3wontdie/art/Magical-Hats-Magic-Artwork-760500482
