variable "node_name" {
  type        = string
  description = "The name of the proxmox node to host this resource"
}
variable disk_size {
    type = string
    description = "the size in gb of the disk for this resource"
}
variable tags {
  type = list(string)
  description = "tags in proxmox"
  default = [ "terraform" ]
}
variable "datastore_id" {
    type = string
    description = "the name of the datastore to host this resource"
}
variable "on" {
    type = bool
    description = "set resource on or off"
}
variable "hostname" {
  type = string
  description = "hostname of the resource"
}
variable "username" {
  type = string
  description = "username"
}
variable "vlan_id" {
  type = number
  description = "VLAN tag that the resource network interface will use"
  default = null
}
variable "bridge" {
  type = string
  description = "network bridge to use for resource"
  default = "vmbr0"
}
variable "template_file_id" {
    type = string
    description = "file id for the resource template"
}