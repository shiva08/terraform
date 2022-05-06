variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  default     = "eastus2euap"
  description = "Location of the resource group."
}

variable "vm_count" {
  default     = 3
  description = "Number of VMs to be created"
}
