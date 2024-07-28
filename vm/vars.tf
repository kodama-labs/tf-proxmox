variable "node_name" {
  type        = string
  description = "The name of the proxmox node to host this resource"
}
variable "has_qemu_agent" {
  type = bool
  description = "tells proxmox that the qemu agent is installed and auto-runs for this vm"
  default = false
}
variable "cpu_cores" {
	type = number
	description = "number of CPU cores"
	default = 1
}
variable "cpu_type" {
	type = string
	description = "CPU type (usually ok to leave as default)"
  default = "x86-64-v2-AES"
} 
variable "memory_gb" {
	type = number
	description = "memory in GiB"
	default = 1
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
  default = null
}
variable "username" {
  type = string
  description = "username"
  default = null
}
variable "networking" {
	type = list(object({
		bridge = optional(string, "vmbr0")
		vlan = optional(number, null)
		ipv4 = optional(string, "dhcp")
    ipv4_gateway = optional(string, null)
	}))
	default = [{}]
	description = "a list of all your networking devices. defaults to a single nic attached to vmbr0, no vlan, and with dhcp."
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
variable "user_data_file_id" {
  type = string
  description = "file id for a user data file snippet"
  default = null
}
variable "pubkey" {
  type = string
  default = null
}
