# Admin password generation
resource "random_password" "password" {
  length           = 30
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  override_special = "!#()-_=+[]{}?"
}




# Network interface
resource "azurerm_network_interface" "VirtualMachineNic" {
  # References: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface 
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  name                = "${var.virtual_machine_name}-01-NIC"
  #enable_ip_forwarding          = false
  #enable_accelerated_networking = var.enable_accelerated_networking
  ip_configuration {
    name                          = "${var.virtual_machine_name}-ip-configuration-01"
    subnet_id                     = var.virtual_machine_nic_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.virtual_machine_nic_ip_address
  }
}

data "azurerm_image" "search" {
  name                = var.image_name
  resource_group_name = var.resource_group_name
}


# Virtual machine
resource "azurerm_virtual_machine" "VirtualMachine" {
  # References: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

  name                = var.virtual_machine_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  #size                  = var.virtual_machine_size
  #zones                  = var.availability_zone
  network_interface_ids = [azurerm_network_interface.VirtualMachineNic.id]
  vm_size               = var.virtual_machine_size
  #license_type          = "Windows_Server"

  #Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true
  #Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = data.azurerm_image.search.id
  }

  storage_os_disk {
    name = "${var.virtual_machine_name}-OS-01-DISK"

    caching           = var.os_disk_caching
    create_option     = "FromImage"
    disk_size_gb      = var.os_disk_size
    managed_disk_type = var.os_disk_type

  }

  os_profile {
    computer_name  = var.virtual_machine_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }


  /**
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.virtual_machine_sku
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = ""
  }
  */
  os_profile_windows_config {}

  tags = {
    lvmh_app_owner   = var.lvmh_app_owner
    lvmh_application = var.lvmh_application
    lvmh_environment = var.lvmh_environment
    lvmh_maison      = var.lvmh_maison
    lvmh_msp         = var.lvmh_msp
  }
}

resource "azurerm_managed_disk" "data_disk" {
  for_each             = var.data_disk
  name                 = "${var.virtual_machine_name}-DATA-${each.key}-DISK"
  resource_group_name  = var.resource_group_name
  location             = var.resource_group_location
  zone                 = var.availability_zone
  storage_account_type = each.value.data_disk_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.data_disk_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  for_each           = var.data_disk
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = azurerm_virtual_machine.VirtualMachine.id
  lun                = each.key
  caching            = each.value.caching
}
