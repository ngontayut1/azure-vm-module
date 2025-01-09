variable "admin_username" {
  type        = string
  default     = "adminroot"
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "virtual_machine_name" {
  type        = string
  default     = ""
  description = "The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
}

variable "virtual_machine_size" {
  type        = string
  default     = ""
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2."
}

variable "os_disk_size" {
  type        = string
  default     = "128"
  description = "The size of the OS disk"
}

variable "virtual_machine_nic_ip_address" {
  type        = string
  default     = ""
  description = "The Static IP Address which should be used."
}

variable "enable_accelerated_networking" {
  type        = bool
  default     = false
  description = "Should Accelerated Networking be enabled? Defaults to false."
}

variable "virtual_machine_nic_subnet_id" {
  type        = string
  default     = ""
  description = "The ID of the Subnet where this Network Interface should be located in."
}
/*
variable "virtual_machine_sku" {
  type        = string
  default     = "2022-Datacenter"
  description = "Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created."
}
*/

variable "availability_zone" {
  type        = string
  default     = ""
  description = "Specifies the Availability Zone in which this Windows Virtual Machine should be located. Changing this forces a new Windows Virtual Machine to be created."
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group. Changing this forces a new resource to be created"
}

variable "resource_group_location" {
  type        = string
  default     = "francecentral"
  description = "The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "data_disk" {
  type = map(object({
    data_disk_size = number
    caching        = string
    data_disk_type = string
    create_option  = string
  }))
  default     = {}
  description = "The data disks definition."
}

variable "os_disk_type" {
  type        = string
  default     = "Premium_LRS"
  description = "Type of os disk"
}

variable "os_disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "Specifies the caching requirements for the OS Disk"
}

###############
variable "image_name" {
  type = string

  description = "image_name"
}
variable "vm_size" {
  type = string

  description = "vm_size"
}
variable "admin_password" {
  type = string

  description = "admin_password"
}

variable "lvmh_app_owner" {
  description = "lvmh_app_owner"
  type        = string

}
variable "lvmh_application" {
  description = "lvmh_application"
  type        = string

}
variable "lvmh_environment" {
  description = "lvmh_environment"
  type        = string

}

variable "lvmh_maison" {
  description = "lvmh_maison"
  type        = string

}
variable "lvmh_msp" {
  description = "lvmh_msp"
  type        = string

}
