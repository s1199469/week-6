 #
 #  See https://www.terraform.io/intro/getting-started/variables.html for more details.
 #

 #  Change these defaults to fit your needs!
 # generic ESXI connection settings
variable "esxi_hostname" {
  default = "192.168.1.11"
}
variable "esxi_hostport" {
  default = "22"
}
variable "esxi_hostssl" {
  default = "443"
}
variable "esxi_username" {
  default = "root"
}
variable "esxi_password" {
  default = "Welkom01!"
}
variable "virtual_network" {
  default = "VM Network"
}
variable "disk_store" {
  default = "IACDatastore"
}

variable "vm1_provider" {
  default = "esxi"
}
variable "vm1_hostname" {
  default = "serverESX-1"
}
variable "vm1_memsize" {
  default = "2048"
}
variable "vm1_numvcpus" {
  default = "1"  
}
variable "vm1_count" {
  default = "1"
}
variable "vm1_user" {
  default = "testuser"
}
variable "vm1_publickey" {
  default = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPdFA/dN2u/vaHdJBGh8w3I4eBdPD+XUkzIIVW/RMILV generated-by-azure"]
}
variable "vm1_userconfigfile" {
  type =string
  default = "VM1config.tpl"
} 
variable "vm2_provider" {
  default = "azurerm"
}
variable "vm2_hostname" {
  default = "serverAZ-2"
}
variable "vm2_count" {
  default = "1"
}
variable "vm2_adminuser" {
  default = "testuser"
}
variable "vm2_customdatafile" {
  type =string
  default = "vm2userdata.yaml"
}
variable "vm2_resourcegroupname" {
default = "S1199469"  
}
variable "vm2_location" {
  default = "west europe"  
}
variable "vm2_vmsize" {
  default = "Standard_B2ats_v2"
}
variable "vm1_customdatafile" {
  default= "userdata-vm01.yaml"
}
variable "vm2_adminpublickey" {
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3iWLcJxDOFxWieOuQj5dej6DnhygDAtG8Jrq0bZgYI student@devhost"
}
variable "vm2_image_publisher" {
  default = "Canonical"
}
variable "vm2_image_offer" {
  default = "ubuntu-24_04-lts"
}
variable "vm2_image_sku" {
  default = "server-gen1"
}
variable "vm2_image_version" {
  default = "latest"
}
variable "vm2_osdisk_storageaccounttype" {
  default = "Standard_LRS"
}
variable "vm2_osdisk_caching" {
  default = "ReadWrite"
}
