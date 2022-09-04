

resource "azurerm_resource_group" "kubctl_rg" {
  name     = var.azurerm_resource_group_name
  location = var.location

  tags = {
    environemt = var.env
  }

}


resource "azurerm_virtual_network" "ak-vnet" {
  name                = var.vnet_name
  resource_group_name = var.azurerm_resource_group_name
  location            = var.location
  address_space       = var.address_space

  tags = {
    environment = var.env
  }
}


resource "azurerm_subnet" "kubctl_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.kubctl_rg.name
  virtual_network_name = azurerm_virtual_network.ak-vnet.name
  address_prefixes     = var.subnet_prefixes
}

resource "azurerm_network_security_group" "kubctl_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.azurerm_resource_group_name

  security_rule {
    name                       = var.sg_name
    priority                   = var.sg_priority
    direction                  = var.sg_direction
    access                     = var.sg_access
    protocol                   = var.sg_protocol
    source_port_range          = var.s_port_range
    destination_port_range     = var.d_port_range
    source_address_prefix      = var.s_address_prefix
    destination_address_prefix = var.d_address_prefix
  }

  tags = {
    environment = var.env
  }
}

resource "azurerm_subnet_network_security_group_association" "kubctl-nsg-association" {
  subnet_id                 = azurerm_subnet.kubctl_subnet.id
  network_security_group_id = azurerm_network_security_group.kubctl_nsg.id
}

resource "azurerm_public_ip" "kubct_pip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.kubctl_rg.name

  allocation_method = var.ipaddres_method
}

resource "azurerm_network_interface" "kubctl_nic" {
  name                 = var.nic_name
  location             = var.location
  resource_group_name  = var.azurerm_resource_group_name
  enable_ip_forwarding = var.authentication_typr

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = azurerm_subnet.kubctl_subnet.id
    private_ip_address_allocation = var.ipaddres_method
    public_ip_address_id          = azurerm_public_ip.kubct_pip.id
  }
}
resource "azurerm_linux_virtual_machine" "kubctl_linux_vm" {
  name                = var.vm_name
  resource_group_name = var.azurerm_resource_group_name
  location            = var.location
  size                = var.linux_vm_size
  admin_username      = var.username
  network_interface_ids = [
    azurerm_network_interface.kubctl_nic.id,
  ]
  custom_data = filebase64("customdata.tpl")
  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/az-key.pub")

  }

  os_disk {
    caching              = var.linux_os_disk_permission
    storage_account_type = var.sa_type
  }

  source_image_reference {
    publisher = var.OS_publisher
    offer     = var.OS_offer
    sku       = var.OS_sku
    version   = var.OS_version
  }
  

  /* provisioner "local-exec" {
     command = templatefile("windows.ssh.tpl", {
      hostname = self.public_ip_address
      user = var.username,
      identityfile = "~/.ssh/az-key"
    })
    interpreter = ["PowerShell", "-Command"]
  }

  tags = {
    environmet = var.env
  } */


}

