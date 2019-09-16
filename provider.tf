provider "ibm" {
  ibmcloud_api_key   = ""
  softlayer_username = "${var.SOFTLAYER_USERNAME}"
  softlayer_api_key  = "${var.SOFTLAYER_API_KEY}"
}
