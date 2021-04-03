terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url  = "https://${var.pve_host}:${var.pve_port}/api2/json"
  pm_user     = "${var.pve_user}@pam"
  pm_password = var.pve_password
}

resource "proxmox_vm_qemu" "init_master" {
  name        = "rke2-server"
  desc        = "rke2-server"
  target_node = var.pve_target_node
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

resource "proxmox_vm_qemu" "worker1" {
  name        = "rke2-worker1"
  desc        = "rke2-worker1"
  target_node = var.pve_target_node
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

    depends_on = [
    proxmox_vm_qemu.init_master,
  ]
}

resource "proxmox_vm_qemu" "worker2" {
  name        = "rke2-worker2"
  desc        = "rke2-worker2"
  target_node = var.pve_target_node
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

  depends_on = [
    proxmox_vm_qemu.worker1,
  ]
}

resource "proxmox_vm_qemu" "worker3" {
  name        = "rke2-worker3"
  desc        = "rke2-worker3"
  target_node = var.pve_target_node
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

  depends_on = [
    proxmox_vm_qemu.worker2,
  ]
}

output "init_master_address" {
  value = proxmox_vm_qemu.init_master.ssh_host
}

output "worker1_address" {
  value = proxmox_vm_qemu.worker1.ssh_host
}

output "worker2_address" {
  value = proxmox_vm_qemu.worker2.ssh_host
}

output "worker3_address" {
  value = proxmox_vm_qemu.worker3.ssh_host
}