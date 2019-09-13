data "ibm_compute_ssh_key" "ssh_key" {
  label = "my-sshkey"
}


resource "ibm_network_vlan" "httpd_vlan" {
   //depends_on = ["ibm_network_gateway.gatewayEast"]
   name = "tf-ibmcloud-httpd"
   datacenter = "dal12"
   type = "PRIVATE"
   //router_hostname = // in process of deprecating the need to know the exact router hostname
   router_hostname = "bcr02a.dal12" 
   tags = [
     "collectd",
     "mesos-master"
   ]
}


resource "ibm_compute_vm_instance" "ibmcloud_terraform" {
  count             = 1
  hostname          = "ibmcloud.tfhttpd${count.index}"
  domain            = "cdetest.com"
  os_reference_code = "CENTOS_6_64"
  datacenter        = "dal12"
  network_speed     = 100
  cores             = 2
  memory            = 1024
  private_vlan_id   = "${ibm_network_vlan.httpd_vlan.id}"

  ssh_key_ids = ["${data.ibm_compute_ssh_key.ssh_key.id}"]

}



//  Host File Creation 

//create httpd server host file for ansible
data "template_file" "vm_httpdServer" {
  count = "1"
  template = "${file("tmp_hosts/hostServer")}"

  vars {
     myip = "${element(concat(ibm_compute_vm_instance.ibmcloud_terraform.*.ipv4_address, list("")), count.index)}"
     vmHostname = "${element(concat(ibm_compute_vm_instance.ibmcloud_terraform.*.hostname, list("")), count.index)}"
  }
}


resource "local_file" "vm_httpdServer" {
  count = "1"
  content = <<EOF
${element(concat(data.template_file.vm_httpdServer.*.rendered, list("")), count.index)}
EOF

  filename = "${path.cwd}/tmp_hosts/httpdServer${count.index}"

}


data "template_file" "httpd_play" {
  count = "1" 
  template = "${file("${path.cwd}/tmp_playbooks/httpd.yml")}"
  vars {
    vmHostname = "${element(concat(ibm_compute_vm_instance.ibmcloud_terraform.*.hostname, list("")), count.index)}"
  }
}

resource "local_file" "httpd_play" {
  count = 1 
  content = <<EOF
${element(concat(data.template_file.httpd_play.*.rendered, list("")), count.index)}
EOF

  filename = "${path.cwd}/tmp_playbooks/ansiblebook${count.index}"
}


resource "null_resource" "ansible" {
count = 1
depends_on = ["ibm_compute_vm_instance.ibmcloud_terraform"]
  provisioner "local-exec" {
    command = "ansible-playbook -i tmp_hosts/  tmp_playbooks/ansiblebook${count.index}"
  }
}
