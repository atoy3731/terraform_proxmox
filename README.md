### Prereqs

1. You need a CentOS/RHEL PVE template with cloud-init installed.
2. (Multiple target nodes) Your template needs to exist on every single node with the same name.

### Creating an RKE2 Cluster in Proxmox

1. Copy `live.example.tfvars` to `live.tfvars` and update it with your values (look at the comments in the file for more info).
2. Update `ansible_terraform.yml` with the path to this repository on your computer.
```bash
- hosts: localhost
  name: Create infrastructure with Terraforms
  vars:
    terraform_dir: /path/to/this/repo/locally
``` 

3. Init terraform 
```bash
terraform init
```

4. Run Ansible to start the terraform

```bash
ansible-playbook -u CLOUD-INIT-USERNAME --private-key PATH-TO-YOUR-PRIVATE-KEY ansible_terraform.yml
```

***NOTE***

* ssh user must have passwordless auth and passwordless sudo. 
* cloud-init template must already be created
* terraform does not create the cloud-init
