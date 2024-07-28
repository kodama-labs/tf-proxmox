resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.hostname
  description = "Managed by Terraform"
  tags        = sort(var.tags)

  node_name = var.node_name

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = var.has_qemu_agent
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }
  cpu {
		cores = var.cpu_cores
		type = var.cpu_type
	}
  memory {
		dedicated = var.memory_gb * 1024
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

    dynamic "ip_config" {
			for_each = var.networking
			content {
					ipv4 {
						address = ip_config.value["ipv4"]
            gateway = ip_config.value["ipv4_gateway"]
					}
			}
    }

    dynamic user_account {
      # will create this block once if user_data_file_id is null
      for_each = var.user_data_file_id != null ? [] : [""]
      content {
        keys = [
          var.pubkey != null ? trimspace(var.pubkey) : trimspace(tls_private_key.pki_pair.public_key_openssh)
        ]
        password = random_password.password_resource.result
        username = var.username
      }
    }

    user_data_file_id = var.user_data_file_id
    

   }

  dynamic "network_device" {
		for_each = var.networking
		content {
				bridge = network_device.value["bridge"]
				vlan_id = network_device.value["vlan"]
		}
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
