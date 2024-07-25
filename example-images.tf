# the ones on the proxmox website seemed to work best for me
resource "proxmox_virtual_environment_download_file" "jammy_lxc" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "your-node-name"
  url = "http://download.proxmox.com/images/system/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  verify = false
}


# the .img ones worked for me
resource "proxmox_virtual_environment_download_file" "jammy_vm" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "your-node-name"
  url          = "https://cloud-images.ubuntu.com/releases/jammy/release-20240716/ubuntu-22.04-server-cloudimg-amd64.img"
}
