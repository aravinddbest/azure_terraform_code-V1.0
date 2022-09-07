subscription_id = "<___________________>"

client_id = "<______________________>"

client_secret = "<________________>"

tenant_id = "<___________>"

azurerm_resource_group_name = "kubctl_rg"
location                    = "East Us"
vnet_name                   = "kubctl_vent"
subnet_name                 = "kubctl_sub1"
address_space               = ["10.1.0.0/16"]
subnet_prefixes             = ["10.1.1.0/24"]
env                         = "kubctl"
public_ip_name              = "PublicIP"
ipaddres_method             = "Dynamic"
####################  security_group #####################
nsg_name         = "kubctl_nsg"
sg_name          = "All"
sg_priority      = 1001
sg_direction     = "Inbound"
sg_access        = "Allow"
sg_protocol      = "Tcp"
s_port_range     = "*"
d_port_range     = "*"
s_address_prefix = "*"
d_address_prefix = "*"
###################################################

nic_name                 = "kubctl_nic"
ip_config_name           = "kubctl_configuration"
sa_tier                  = "Standard"
rpc_type                 = "LRS"
linux_vm_name            = "kubctl_vm"
linux_vm_size            = "Standard_DS1_v2"
linux_os_disk_name       = "linuxOsDisk"
linux_os_disk_permission = "ReadWrite"
sa_type                  = "Premium_LRS"
OS_publisher             = "Canonical"
OS_offer                 = "UbuntuServer"
OS_sku                   = "18.04-LTS"
OS_version               = "latest"
username                 = "azureuser"
authentication_typr      = true
vm_name                  = "Linux"
#ssh_public_key_path = chomp(file("C:/Users/HP/.ssh/az-key.pub"))
kubctl_storage = "kubctl"
