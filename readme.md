# Cycle1
## Description
- Course: CSC842 Security Tool Development
- Developer: Jacob Williams
- Language: Bash & Terraform
- Scope: Infrastrucure Deployment


## Description
Penetration tests often require a lot of repeat work that can be easily automated.  Multiple solutions for infrasture as code (IaC) exist such as Terraform and Ansible, however they are often static configurations.  By wrapping these configs in an easy to use CLI solution, less time will be spent on infrastructure and more time on hacking!

## Capabilities
MAGICHATS is capable of running multiple instances of HTTP C2 Redirectors and pointing them to a single host.  This is able to be done completely from the commandline and can be destroyed just as easily.

### Functionality
The priamry function of this software is to remotely create, deploy, and destroy cloud nodes.

## Future Work
Currently there is only one module for the framework.  Future modules will extend the functionality of the tool by allowing operators to create and point DNS records to their created instances. Further plug-and-play features will be created to allow minimal change of Terraform config files, allowing users to create in environments they might be more familiar with (Bash, Python, JSON, etc.)

If time allows, extended the CLI to a web application front end will allow for dynamic management of nodes for an entire penetration testing team.  This would provide stability through database connections as well as being just like everything other red team tool these days. :) 

