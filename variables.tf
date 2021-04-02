#######################
# CloudInit variables #
#######################

variable cloud_init_ssh_key {
  type        = string
  description = "SSH key for nodes"
}

variable cloud_init_user {
    type        = string
    default     = "rke2"
    description = "Cloud init user for SSH"
}

#################
# PVE variables #
#################

variable pve_host {
    type        = string
    description = "Hostname for PVE"
}

variable pve_port {
    type        = number
    default     = 8006
    description = "Port for PVE"
}

variable pve_user {
    type        = string
    default     = "root"
    description = "User for PVE"
}

variable pve_password {
    type        = string
    description = "Password for PVE (HIGHLY ADVISABLE TO PASS THIS AT APPLY INSTEAD OF IN A FILE)"
    # sensitive   = true # Enable with TF 0.14 and experimentals enabled
}

variable pve_target_node {
    type        = string
    description = "Name of the PVE node to target for deployment"
}

variable pve_network_bridge {
    type        = string
    default     = "vmbr0"
    description = "Network bridge on PVE node"
}

variable pve_template_name {
    type        = string
    description = "Name of the PVE template (requires cloudinit)"
}

variable pve_storage_name {
    type        = string
    description = "Name of PVE storage on target node"
}

####################
# Server variables #
####################

variable rke2_server_memory {
    type        = number
    default     = 2048
    description = "Memory for server node (in MB)"
}

variable rke2_server_cores {
    type        = number
    default     = 3
    description = "CPU cores for server"
}

variable rke2_server_sockets {
    type        = number
    default     = 1
    description = "CPU sockets for server"
}

variable rke2_server_storage_size {
    type        = number
    default     = 32
    description = "Size of storage for server node (in GB)"  
}

####################
# Worker variables #
####################

variable rke2_worker_memory {
    type        = number
    default     = 2048
    description = "Memory for worker nodes (in MB)"
}

variable rke2_worker_cores {
    type        = number
    default     = 2
    description = "CPU cores for workers"
}

variable rke2_worker_sockets {
    type        = number
    default     = 1
    description = "CPU sockets for workers"
}

variable rke2_worker_storage_size {
    type        = number
    default     = 32
    description = "Size of storage for worker nodes (in GB)"  
}