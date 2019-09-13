IBM Cloud VSI with Httpd Install and Started</br></br>
Example of how to deploy a VSI that will have httpd installed and running on IBM Cloud. This allows for greater automation for customers that need services installed on devices after provisioning and centralized files uploaded. </br></br>

The code in this example will:</br>
*	Create a Premium Vlan</br>
*	Create a VSI</br>
*	Place an SSH Key (in IBM Cloud portal) on the VSI</br>
*	Kick off an Ansible Playbook that will </br>
* Install Httpd</br>
*	Start the Httpd service</br>
*	Install libselinux-python to enable copy ability</br>
*	Copy an index.html file to the VSI from the local device</br></br>

Prerequisites</br>
*	In order to use this example code, you will need an upgraded IBM Cloud account. Don’t have an IBM Cloud account yet?  Sign up here.</br>
*	Terraform and the IBM Terraform provider plugin installed. Guide.</br>
*	Ansible installed. Guide.</br>
*	An IBM Cloud PaaS and IaaS API key. Guide.</br>
*	Generate an SSH Key and upload to IBM Cloud portal.  Guide. </br></br>