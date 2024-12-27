resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address = var.private_ip_address
  }



}
data "azurerm_image" "search" {
  name                = var.image_name
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_machine" "vm" {
  for_each             = var.vm_list
  name                 = each.value.vm_name
  location             = each.value.location
  resource_group_name  = each.value.resource_group_name
  network_interface_ids = [each.value.network_interface_id]
  vm_size              = each.value.vm_size


###
  #Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true
  #Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = data.azurerm_image.search.id
  }
####
  storage_os_disk {
    name              = "${each.value.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    disk_size_gb      = var.disk_size_gb_osdisk
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = each.value.vm_name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }

    os_profile_windows_config {}

  tags = {
    lvmh_app_owner   = var.lvmh_app_owner
    lvmh_application = var.lvmh_application
    lvmh_environment = var.lvmh_environment
    lvmh_maison      = var.lvmh_maison
    lvmh_msp         = var.lvmh_msp
  }
}

