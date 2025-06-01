 #  variables.terraform 
 #  zie: https://www.terraform.io/intro/getting-started/variables.html 
 #

 # Deze lijst bevat variabelen declaraties
 # Voor herbruikbaarheid bevat deze lijst geen waarden. 
 # Gebruik .tfvars files om de waarden op te geven 

variable "esxi_hostname" {
  type = string
}
variable "esxi_hostport" {
  type = string
}
variable "esxi_hostssl" {
  type = string
}
variable "esxi_username" {
  type = string
}
variable "esxi_password" {
  type = string
}
variable "virtual_network" {
  type = string
}
variable "disk_store" {
  type = string
}

variable "vm1_ID" {
  type = string
  default = "ESXT1"
}

variable "vm1_provider" {
  type = string
}
variable "vm1_hostname" {
  type = string
}
variable "vm1_memsize" {
  type = string
}
variable "vm1_numvcpus" {
  type = string
}
variable "vm1_count" {
  type = string
}
variable "vm1_user" {
  type = string
}
variable "vm1_publickey" {
  type = string
  default= ""
}
variable "vm1_userconfigfile" {
  type =string
} 
variable "vm2_provider" {
  type = string
}
variable "vm2_hostname" {
  type = string
}
variable "vm2_count" {
  type = string
}
variable "vm2_adminuser" {
  type = string
}
variable "vm2_customdatafile" {
  type =string
}
variable "vm2_resourcegroupname" {
type = string 
}
variable "vm2_location" {
  type = string
}
variable "vm2_vmsize" {
  type = string
}
variable "vm2_adminpublickey" {
  type = string
}
variable "vm2_image_publisher" {
  type = string
}
variable "vm2_image_offer" {
  type = string
}
variable "vm2_image_sku" {
  type = string
}
variable "vm2_image_version" {
  type = string
}
variable "vm2_osdisk_storageaccounttype" {
  type = string
}
variable "vm2_osdisk_caching" {
  type = string
}
