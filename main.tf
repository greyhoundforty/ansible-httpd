data "ibm_compute_ssh_key" "ssh_key" {
  label = "ryan_tycho_2019"
}

resource "ibm_network_vlan" "httpd_vlan" {
   name = "test-rt"
   datacenter = "dal12"
   type = "PRIVATE"
   router_hostname = "bcr02a.dal12"
   tags = ["user:${var.SOFTLAYER_USERNAME}"]
}


resource "ibm_compute_vm_instance" "ibmcloud_terraform" {
  count             = "${var.node_count}"
  hostname          = "ibmcloud.test${count.index}"
  domain            = "cdetest.com"
  os_reference_code = "CENTOS_6_64"
  datacenter        = "dal12"
  network_speed     = 1000
  flavor_key_name   = "B1_2X4X100"
  local_disk = false 
  private_vlan_id   = "${ibm_network_vlan.httpd_vlan.id}"
  ssh_key_ids = ["${data.ibm_compute_ssh_key.ssh_key.id}"]
}



//  Host File Creation 

//create httpd server host file for ansible
data "template_file" "vm_httpdServer" {
  count = "${var.node_count}"
  template = "${file("Templates/hostServer.tpl")}"

  vars {
     myip = "${element(concat(ibm_compute_vm_instance.ibmcloud_terraform.*.ipv4_address, list("")), count.index)}"
     vmHostname = "${element(concat(ibm_compute_vm_instance.ibmcloud_terraform.*.hostname, list("")), count.index)}"
  }
}


resource "local_file" "vm_httpdServer" {
  count = "${var.node_count}"
  content = <<EOF
${element(concat(data.template_file.vm_httpdServer.*.rendered, list("")), count.index)}
EOF

  filename = "${path.cwd}/Inventory/httpdServer${count.index}"

}


data "template_file" "httpd_play" {
  count = "${var.node_count}" 
  template = "${file("${path.cwd}/Templates/httpd.yml.tpl")}"
  vars {
    vmHostname = "${element(concat(ibm_compute_vm_instance.ibmcloud_terraform.*.hostname, list("")), count.index)}"
  }
}

resource "local_file" "httpd_play" {
  count = "${var.node_count}" 
  content = <<EOF
${element(concat(data.template_file.httpd_play.*.rendered, list("")), count.index)}
EOF

  filename = "${path.cwd}/Playbooks/ansiblebook${count.index}"
}


resource "null_resource" "ansible" {
count = "${var.node_count}"
depends_on = ["ibm_compute_vm_instance.ibmcloud_terraform"]
  provisioner "local-exec" {
    command = "ansible-playbook -i Inventory/ Playbooks/ansiblebook${count.index}"
  }
}
