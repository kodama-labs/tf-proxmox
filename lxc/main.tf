resource "proxmox_virtual_environment_container" "container" {
  description = "Managed by Terraform"
  
  node_name = var.node_name
  tags = var.tags
  unprivileged = ! var.privileged

  disk {
    datastore_id = var.datastore_id
    size = var.disk_size
  }
  started = var.on
  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ipv4_addr
        gateway = var.ipv4_gateway 
      }
    }

    user_account {
      keys = [
        var.pubkey != null ? trimspace(var.pubkey) : trimspace(tls_private_key.pki_pair.public_key_openssh)
      ]
      password = random_password.password_resource.result
    }
  }

  network_interface {
    name = "eth0"
    bridge = var.bridge
    vlan_id = var.vlan_id
  }

  operating_system {
    template_file_id = var.template_file_id
    type             = "ubuntu"
  }




}

resource "random_password" "password_resource" {
  length           = 16
  override_special = "_@&$#"
  special          = true
}

resource "tls_private_key" "pki_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "password" {
  value     = random_password.password_resource.result
  sensitive = true
}

output "private_key" {
  value     = tls_private_key.pki_pair.private_key_pem
  sensitive = true
}

output "public_key" {
  value = tls_private_key.pki_pair.public_key_openssh
}