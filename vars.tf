variable "ssh_key" {
    type = string
}

variable "proxmox_host" {
    description = "The name of the proxmox node"
    type = string
    default = "proxmox"
}

variable "template_name" {
    description = "The name of the pre-configured OS image"
    type = string
}

variable "proxmox_token_id" {
    type = string
}

variable "proxmox_token_secret" {
    type = string 
}

variable "proxmox_endpoint" {
    type = string 
}
