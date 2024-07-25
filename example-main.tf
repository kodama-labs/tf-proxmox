module "test-lxc" {
  source = "./lxc"
  node_name = "your-node-name"
  datastore_id = "local-lvm"
  disk_size = 30
  hostname = "test-lxc-1"
  on = true
  # vlan_id = 12
  bridge = "<specify network bridge>"
  privileged = false
  ipv4_addr = "192.168.12.12/24"
  ipv4_gateway = "192.168.12.1"
  pubkey = "<specify pubkey here>"
  template_file_id = proxmox_virtual_environment_download_file.jammy_lxc.id
}

module "test-vm" {
    source = "./vm"
    node_name = "your-node-name"
    username = "test"
    datastore_id = "local-lvm"
    disk_size = 30
    hostname = "vm-test"
    tags = ["terraform", "ubuntu", "test"]
    on = true
    # vlan_id = 12
    bridge = "<specify network bridge>"
    template_file_id = proxmox_virtual_environment_download_file.jammy_vm.id
}
