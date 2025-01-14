resource "azurerm_resource_group" "vm" {
  name     = "vm-resources"
  location = "West Europe"
}

resource "azurerm_public_ip" "main" {
  count               = 2
  name                = "vm-public-ip-${count.index}"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  count               = 2
  name                = "vm-nic-${count.index}"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[count.index].id
  }
}

resource "azurerm_virtual_machine" "main" {
  count                 = 2
  name                  = "vm-${count.index}"
  location              = azurerm_resource_group.vm.location
  resource_group_name   = azurerm_resource_group.vm.name
  network_interface_ids = [azurerm_network_interface.main[count.index].id]
  vm_size               = "Standard_DS1_v2"

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "vm"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    custom_data    = base64encode(file("startup.sh"))
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}