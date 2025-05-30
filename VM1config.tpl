 #cloud-config
packages:
  - wget
  - ntpdate

users:
  - default
  - name: ${USER}
    sudo: ALL=(ALL) NOPASSWD:ALL
    
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3iWLcJxDOFxWieOuQj5dej6DnhygDAtG8Jrq0bZgYI student@devhost
    shell: /bin/bash
runcmd:
  - hostnamectl set-hostname ${HOSTNAME}
  - date >>/root/cloudinit.log 
  
