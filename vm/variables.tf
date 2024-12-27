variable "vm_list" {
  description = "List of VM configurations"
  type = list(object({
    vm_name              = string
    location             = string
    resource_group_name  = string
    network_interface_id = string
    vm_size              = string
    admin_username       = string
    admin_password       = string
  }))
}
