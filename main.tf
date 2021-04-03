terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
    }
  }
}

resource "random_shuffle" "rke2_server_target_nodes" {
  input        = var.pve_target_nodes
  result_count = var.rke2_server_count
}

resource "random_shuffle" "rke2_worker_target_nodes" {
  input        = var.pve_target_nodes
  result_count = var.rke2_worker_count
}

provider "proxmox" {
  pm_api_url  = "https://${var.pve_host}:${var.pve_port}/api2/json"
  pm_user     = "${var.pve_user}@pam"
  pm_password = var.pve_password
}

resource "proxmox_vm_qemu" "init-master" {
  name        = "rke2-server0"
  desc        = "rke2-server0"
  target_node = random_shuffle.rke2_server_target_nodes.result[0]
  onboot      = "true"
  full_clone  = var.pve_full_clone
  clone       = var.pve_template_name
  cores       = var.rke2_server_cores
  sockets     = var.rke2_server_sockets
  memory      = var.rke2_server_memory
  agent       = 1
  ipconfig0   = "ip=dhcp"
  ciuser      = var.cloud_init_user
  sshkeys     = var.cloud_init_ssh_key

  disk {
    type    = "scsi"
    storage = var.pve_storage_name
    size    = "${var.rke2_server_storage_size}G"
  }

  # Set the network
  network {
    model  = "virtio"
    bridge = var.pve_network_bridge
  }
}

resource "proxmox_vm_qemu" "additional-masters" {
  count = var.rke2_server_count > 1 ? (var.rke2_server_count - 1) : 0

  name        = "rke2-server${count.index + 1}"
  desc        = "rke2-server${count.index + 1}"
  target_node = random_shuffle.rke2_server_target_nodes.result[count.index + 1]
  onboot      = "true"
  full_clone  = var.pve_full_clone
  clone       = var.pve_template_name
  cores       = var.rke2_server_cores
  sockets     = var.rke2_server_sockets
  memory      = var.rke2_server_memory
  agent       = 1
  ipconfig0   = "ip=dhcp"
  ciuser      = var.cloud_init_user
  sshkeys     = var.cloud_init_ssh_key

  disk {
    type    = "scsi"
    storage = var.pve_storage_name
    size    = "${var.rke2_server_storage_size}G"
  }

  # Set the network
  network {
    model  = "virtio"
    bridge = var.pve_network_bridge
  }
}

resource "proxmox_vm_qemu" "workers" {
  count = var.rke2_worker_count

  name        = "rke2-worker${count.index}"
  desc        = "rke2-worker${count.index}"
  target_node = random_shuffle.rke2_worker_target_nodes.result[count.index]
  onboot      = "true"
  full_clone  = var.pve_full_clone
  clone       = var.pve_template_name
  cores       = var.rke2_worker_cores
  sockets     = var.rke2_worker_sockets
  memory      = var.rke2_worker_memory
  agent       = 1
  ipconfig0   = "ip=dhcp"
  ciuser      = var.cloud_init_user
  sshkeys     = var.cloud_init_ssh_key

  disk {
    type    = "scsi"
    storage = var.pve_storage_name
    size    = "${var.rke2_worker_storage_size}G"
  }

  # Set the network
  network {
    model  = "virtio"
    bridge = var.pve_network_bridge
  }
}

output "init_master_address" {
  value = proxmox_vm_qemu.init-master.ssh_host
}

output "additional_master_addresses" {
  value = ["${proxmox_vm_qemu.additional-masters.*.ssh_host}"]
}

output "worker_addresses" {
  value = ["${proxmox_vm_qemu.workers.*.ssh_host}"]
}