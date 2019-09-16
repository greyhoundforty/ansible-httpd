# IBM Cloud VSI with Httpd Install and Started
Example of how to deploy a VSI that will have httpd installed and running (courtesy of ansible) on IBM Cloud. This allows for greater automation for customers that need services installed on devices after provisioning and centralized files uploaded.

## The code in this example will:
 - Create a Premium Vlan
 - Create a VSI
 - Place an SSH Key (in IBM Cloud portal) on the VSI
 - Kick off an Ansible Playbook that will 
    - Install Httpd
    - Start the Httpd service
	- Install libselinux-python to enable copy ability
	- Copy an index.html file to the VSI from the local device

### Prerequisites
* In order to use this example code, you will need an upgraded IBM Cloud account. Don’t have an IBM Cloud account yet?  [Sign  Up Here](https://cloud.ibm.com/registration) 
* Terraform and the IBM Terraform provider plugin installed. [Guide](https://cloud.ibm.com/docs/terraform?topic=terraform-getting-started#install). 
* Ansible installed. [Guide](https://cloud.ibm.com/docs/terraform?topic=terraform-getting-started#install).
* An IBM Cloud PaaS and IaaS API key. [Guide](https://cloud.ibm.com/docs/iam?topic=iam-userapikey). 
* Generate an SSH Key and upload to IBM Cloud portal.  [Guide](https://cloud.ibm.com/docs/infrastructure/ssh-keys?topic=ssh-keys-adding-an-ssh-key).

## Configuration
See the repositories wiki for a [Guide](https://github.com/greyhoundforty/ansible-httpd/wiki) on how to use this example code.
