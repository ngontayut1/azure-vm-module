output "vm_ids" {
  description = "List of Virtual Machine IDs"
  value       = [for vm in azurerm_virtual_machine.vm : vm.id]
}
