variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "rg-azure-home-assignment"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "Sweden Central"
}

variable "vnet_name" {
  description = "Virtual Network Name"
  type        = string
  default     = "vnet-azure-home-assignment"
}

variable "address_space" {
  description = "VNet Address Space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "home_ip" {
  description = "Trusted public IP address for SSH access"
  type        = string
  default     = "146.255.140.176/32"
}

variable "storage_account_name" {
  description = "Storage Account Name"
  type        = string
  default     = "stazurehomeassign01"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "C:/Keys/vm-app-01_key.pub"
}

variable "alert_email" {
  description = "Email address for Azure Monitor alert notifications"
  type        = string
}