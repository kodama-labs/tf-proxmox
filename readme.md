# Terraform on proxmox

This repository is a collection of terraform modules that I have developed for use in proxmox. 

In order to get terraform to play nice with proxmox, you have to do a few things.

I used terraform provider docs (bpg/proxmox) as a starting point. First I made a terraform user in proxmox using cli.

```
pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Allocate Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
pveum user add terraform@pve --password <password>
pveum aclmod / -user terraform@pve -role TerraformProv
pveum user token add terraform@pve provider --privsep=0
```

and then I followed the instructions to create a linux terraform user on the proxmox host itself as well. This turns out to be an important step especially for creating VMs, otherwise there are some things you cannot do. Allow this service account on the proxmox host to login via ssh and provide it with a public key

Finally you need to give all these parameters to terraform. i have an example env file with the basics that can be modified to suit anybody else's needs.


