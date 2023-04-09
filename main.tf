terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.8.0"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://${var.proxmox_endpoint}/api2/json"
  pm_api_token_id = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "sandbox-vm" {
  count = 1
  name = "sandbox-vm-${count.index + 1}"
  vmid = "90${count.index + 1}"

  target_node = var.proxmox_host
  clone = var.template_name

  agent = 1
  memory = 2048
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 0
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.50.9${count.index + 1}/24,gw=192.168.50.1"

  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF

}

resource "proxmox_vm_qemu" "kube-server" {
  count = 1
  name = "kube-server-0${count.index + 1}"
  vmid = "20${count.index + 1}"

  target_node = var.proxmox_host
  clone = var.template_name

  agent = 1
  memory = 4096
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 0
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.50.2${count.index + 1}/24,gw=192.168.50.1"

  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
  
}

resource "proxmox_vm_qemu" "kube-agent" {
  count = 2
  name = "kube-agent-0${count.index + 1}"
  vmid = "30${count.index + 1}"

  target_node = var.proxmox_host
  clone = var.template_name

  agent = 1
  memory = 4096
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  disk {
    slot = 0
    size = "20G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 0
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.50.3${count.index + 1}/24,gw=192.168.50.1"

  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
  
}

resource "proxmox_vm_qemu" "kube-storage" {
  count = 1
  name = "kube-storage-0${count.index + 1}"
  vmid = "40${count.index + 1}"

  target_node = var.proxmox_host
  clone = var.template_name

  agent = 1
  memory = 4096
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 0
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.50.4${count.index + 1}/24,gw=192.168.50.1"

  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
  
}