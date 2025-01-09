output "network_interface_id" {
  description = "IDs of the VM NICs provisoned."
  value       = azurerm_network_interface.VirtualMachineNic.id
}

output "network_interface_private_ip" {
  description = "Private IP addresses of the VM NICs"
  value       = azurerm_network_interface.VirtualMachineNic.private_ip_address
}

output "network_interface_ip_configuration" {
  description = "Name of the VM IP configuration"
  value       = azurerm_network_interface.VirtualMachineNic.ip_configuration
}