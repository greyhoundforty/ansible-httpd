#  IBM Cloud VSI with Httpd Install and Started</br></br>
Example of how to deploy a VSI that will have httpd installed and running on IBM Cloud. This allows for greater automation for customers that need services installed on devices after provisioning and centralized files uploaded. </br></br>

### The code in this example will:</br>
*	Create a Premium Vlan</br>
*	Create a VSI</br>
*	Place an SSH Key (in IBM Cloud portal) on the VSI</br>
*	Kick off an Ansible Playbook that will </br>
* Install Httpd</br>
*	Start the Httpd service</br>
*	Install libselinux-python to enable copy ability</br>
*	Copy an index.html file to the VSI from the local device</br></br>

### Prerequisites</br>
* In order to use this example code, you will need an upgraded IBM Cloud account. Don’t have an IBM Cloud account yet?  [Sign  Up Here](https://cloud.ibm.com/registration)  </br> 
* Terraform and the IBM Terraform provider plugin installed. [Guide](https://cloud.ibm.com/docs/terraform?topic=terraform-getting-started#install).  </br>
* Ansible installed. [Guide](https://cloud.ibm.com/docs/terraform?topic=terraform-getting-started#install).  </br>
* An IBM Cloud PaaS and IaaS API key. [Guide](https://cloud.ibm.com/docs/iam?topic=iam-userapikey).  </br>
* Generate an SSH Key and upload to IBM Cloud portal.  [Guide](https://cloud.ibm.com/docs/infrastructure/ssh-keys?topic=ssh-keys-adding-an-ssh-key).   <br/><br/>

### Configuration<br/>
See the repositories wiki for a [Guide](https://github.com/gitcoldlight36/ansible-httpd/wiki/Httpd-Ansible-Wiki) on how to use this example code.
