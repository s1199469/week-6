esxi_hostname = "192.168.1.11"
esxi_hostport = "22"
esxi_hostssl = "443"
esxi_username = "root"
esxi_password = "Welkom01!"
virtual_network = "VM Network"
disk_store = "IACDatastore"
vm1_provider = "esxi"
vm1_hostname = "serverESX-T-01"
vm1_memsize = "2048"
vm1_numvcpus = "1"
vm1_count = "1"
vm1_user = "testuser"
vm1_userconfigfile = "VM1config-t.tpl"
vm2_provider = "azurerm"
vm2_hostname = "serverAZ-T-01"
vm2_count = "2"
vm2_adminuser = "testuser"
vm2_customdatafile = "vm2userdata-t.yaml"
vm2_resourcegroupname = "S1199469"
vm2_location = "west europe"
vm2_vmsize = "Standard_B2ats_v2"
vm2_adminpublickey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3iWLcJxDOFxWieOuQj5dej6DnhygDAtG8Jrq0bZgYI student@devhost"
vm2_image_publisher = "Canonical"
vm2_image_offer = "ubuntu-24_04-lts"
vm2_image_sku = "server-gen1"
vm2_image_version = "latest"
vm2_osdisk_storageaccounttype = "Standard_LRS"
vm2_osdisk_caching = "ReadWrite"
vm_publickey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPadDmXA/5+PVv7sNLlvv/iaPdZEI+PPA57ZGC9wmXtt student@devhost"