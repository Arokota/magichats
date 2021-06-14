# Cycle4
## Description
- Course: CSC842 Security Tool Development
- Developer: Jacob Williams
- Language: Bash & Terraform
- Scope: Infrastrucure Deployment

## Timeline
- Create terraform backend (Cycle2)
- Create FastAPI backend with focus on further extensibility (Cycle4)
- Create Vue JS Web App frontend (Cycle4)



## Description
Penetration tests often require a lot of repeat work that can be easily automated.  Multiple solutions for infrasture as code (IaC) exist such as Terraform and Ansible, however they are often static configurations.  By wrapping these configs in an easy to use WebApp solution, less time will be spent on infrastructure and more time on hacking!

## Capabilities
MAGICHATS is capable of running multiple instances of HTTP C2 Redirectors and pointing them to a single host.  This is able to be done completely from the commandline and can be destroyed just as easily.

### Functionality
The priamry function of this software is to remotely create, deploy, and destroy cloud nodes.

## Future Work
Currently there is only one module for the framework.  Future modules will extend the functionality of the tool by allowing operators to create and point DNS records to their created instances. Further plug-and-play features will be created to allow minimal change of Terraform config files, allowing users to create in environments they might be more familiar with (Bash, Python, JSON, etc.)

Going forward the focus will be to extend the application's front end in order to allow for easy management of nodes through a simple and intuitive web interface.

