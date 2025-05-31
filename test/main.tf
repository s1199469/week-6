
 # Deploy 1 Ubuntu server VM op ESXi en 1 Ubuntu server VM op Azure
 # Details voor de provider
provider "esxi" {
  esxi_hostname      = var.esxi_hostname
  esxi_hostport      = var.esxi_hostport
  esxi_hostssl       = var.esxi_hostssl
  esxi_username      = var.esxi_username
  esxi_password      = var.esxi_password
}
 # Template voorconfiguratie bash script
 # met cloud-init

data "template_file" "serverESX1" {
  template = file(var.vm1_userconfigfile)
  vars = {
    HOSTNAME = var.vm1_hostname
    USER = var.vm1_user
    
  }
}
data "template_file" "serverAZ2" {
  template = file(var.vm2_customdatafile)
  vars = {
    HOSTNAME = var.vm2_hostname
    USER = var.vm2_adminuser
    
  }
}

 # VM-1 deployment

 resource "esxi_guest" "serverESX1" {
  guest_name         = var.vm1_hostname
  disk_store         = var.disk_store
  memsize            = var.vm1_memsize
  numvcpus           = var.vm1_numvcpus
  count              = var.vm1_count

  ovf_source = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.ova"

    network_interfaces {
      virtual_network = var.virtual_network
    }

 # Voer cloud-init template uit
  guestinfo = {
    "userdata.encoding" = "gzip+base64"
    "userdata"          = base64gzip(data.template_file.serverESX1.rendered)
  # "userdata"          = "filebase64.cloud-init.yaml"
  # "userdata.encoding" = "base64"
  }

 }

 # VM-2 deployment
 # resource deployment
 # resource group aanmaken is weggelaten om te voorkomen dat de huidige RG per ongeluk wordt verwijderd
 # bij een terraform destroy
 # om een VM te kunnen aanmaken is er een virueel netwerk en publiek IP adres nodig
 
 # Details voor de provider
 
provider "azurerm" {
  resource_provider_registrations = "none"
  tenant_id = "e36377b7-70c4-4493-a338-095918d327e9"
  subscription_id = "c064671c-8f74-4fec-b088-b53c568245eb"
  features {}
  }
  
 resource "azurerm_virtual_network" "main" {
  name                = "${var.vm2_hostname}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.vm2_location}"
  resource_group_name = "${var.vm2_resourcegroupname}"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${var.vm2_resourcegroupname}"
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.vm2_hostname}-pip"
  resource_group_name = "${var.vm2_resourcegroupname}"
  location            = "${var.vm2_location}"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
# netwerkkaart is een apart resource dat later aan de VM wordt gekoppeld
resource "azurerm_network_interface" "main" {
  name                = "${var.vm2_hostname}-nic"
  resource_group_name = "${var.vm2_resourcegroupname}"
  location            = "${var.vm2_location}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# Deploy VM-2 (Azure)

resource "azurerm_linux_virtual_machine" "serverAZ2" {
  name                = "${var.vm2_hostname}"
  resource_group_name = "${var.vm2_resourcegroupname}"
  location            = "${var.vm2_location}"
  size                = "${var.vm2_vmsize}"
  admin_username      = "${var.vm2_adminuser}"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "${var.vm2_adminuser}"
    public_key = "${var.vm2_adminpublickey}"
    
  }
# cloud-init instructies
custom_data = base64encode(file("${var.vm2_customdatafile}"))

  source_image_reference {
    publisher = "${var.vm2_image_publisher}"
    offer     = "${var.vm2_image_offer}"
    # https://documentation.ubuntu.com/azure/azure-how-to/instances/find-ubuntu-images/
    sku       = "${var.vm2_image_sku}"
    version   = "${var.vm2_image_version}"
  }

  os_disk {
    storage_account_type = "${var.vm2_osdisk_storageaccounttype}"
    caching              = "${var.vm2_osdisk_caching}"
  }
}

# outputs zijn gedfinieerd in outputs.tf
# fix voor lege public ip adress outputvelden
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip.html

data "azurerm_public_ip" "pip" {
  name                = azurerm_public_ip.pip.name
  resource_group_name = azurerm_linux_virtual_machine.serverAZ2.resource_group_name
}

output "public_ip_addressVM1" {
  value = data.azurerm_public_ip.pip.ip_address
}



# wegschrijven IP adressen in file
locals {
  ipsESX = [esxi_guest.serverESX1[0].ip_address]
  ipsAZ = [data.azurerm_public_ip.pip.ip_address]
}
resource "local_file" "ipaddresses" {
   content = <<-EOT
   [ESXservers]
   %{ for ip in local.ipsESX }${ip}
   %{ endfor }
   [AZservers]
   %{ for ip in local.ipsAZ }${ip}
   %{ endfor }

   [all:vars]
   ansible_user=testuser
   ansible_ssh_private_key_file=~/.ssh/week6key
   EOT

   filename = "${path.module}/inventory.ini"
}
#  Outputs are a great way to output information about your apply.
#

# output bij gebruik van count kan charmanter, nog niet gevonden 
# hoe dat met een for loop zou kunnen
output "ip1" {
  value = esxi_guest.serverESX1[0].ip_address
}