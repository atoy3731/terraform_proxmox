### Creating an RKE2 Cluster in Proxmox

1. Copy `live.example.tfvars` to `live.tfvars` and update it with your values.
2. Update `ansible_terraform.yml` with the path to this repository on your computer.

3. Init terraform 
```bash
terraform init
```

4. Run Ansible to start the terraform

```bash
ansible-playbook ansible_terraform.yml
```

NOTE***

ssh user must have passwordless auth and passwordless sudo. 

cloud-init template must already be created

terraform does not create the cloud-init