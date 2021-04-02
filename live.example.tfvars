#######################
# CloudInit variables #
#######################

cloud_init_ssh_key = ""  # Your public SSH key (enabled for SSH)
cloud_init_user = ""  # Name for your cloud-init user (enabled for SSH)

#################
# PVE variables #
#################

pve_host = ""  # Hostname for Proxmox to connect to.
pve_target_node = ""  # Name of Proxmox node in cluster to deploy RKE2 to.
pve_template_name = ""  # Name of cloud-init enabled PVE template.
pve_storage_name = ""  # Name of PVE storage.

# pve_port = 8006  # Already defaulted to 8006, only change if you're using non-standard port.
# pve_user = "root"  # Already defaulted to 'root', only change if you're using non-standard username.
# pve_password = ""  # Password for PVE (HIGHLY ADVISABLE TO PASS THIS AT APPLY INSTEAD OF IN THIS FILE)" 

#########################
# RKE2 Server variables #
#########################

rke2_server_memory = 2048  # In MB
rke2_server_cores = 3
rke2_server_sockets = 1
rke2_server_storage_size = 32  # In GB

####################
# Worker variables #
####################

rke2_worker_memory = 2048  # In MB
rke2_worker_cores = 3
rke2_worker_sockets = 1
rke2_worker_storage_size = 32  # In GB