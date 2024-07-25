resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.hostname
  description = "Managed by Terraform"
  tags        = var.tags

  node_name = var.node_name

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = false
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = var.template_file_id
    interface    = "virtio0"
    iothread = true
    size = var.disk_size
  }

  initialization {
    datastore_id = var.datastore_id
    interface = "ide0"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      keys = [
        var.pubkey != null ? trimspace(var.pubkey) : trimspace(tls_private_key.pki_pair.public_key_openssh)
      ]
      password = random_password.password_resource.result
      username = var.username
    }

   }

  network_device {
    bridge = var.bridge
    vlan_id = var.vlan_id
  }

  operating_system {
    type = "l26" # linux
  }

}


resource "random_password" "password_resource" {
  length           = 16
  override_special = "_@&$#"
  special          = true
}

resource "tls_private_key" "pki_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
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
