<#
.DESCRIPTION
   Creates a private network in Hyper-V with NAT. This allows for VMs to be hidden from the host's LAN while 
   also providing network and internet connectivity.
   Not meant to be run as a script. Assign or replace variables with desired config to run.
   When configuring IP settings on VMs in the NAT network, set the gateway to the IP address of the virtual 
   NIC on the host connected to the new VM Switch.
#>

# Creates a new internal VM switch in Hyper-V
New-VMSwitch -SwitchName $switchname -SwitchType Internal

# Sets a static IP address on the host interface connected to the new vswitch.
# the IP address should be inside the subnet NAT is configured for.
New-NetIPAddress -IPAddress $interface_address -PrefixLength 24 -InterfaceAlias "vEthernet ($switchname)"

# Creates the NAT network with address space in CIDR notation. e.g. 192.168.100.1/24
New-NetNat -Name "$natname" -InternalIPInterfaceAddressPrefix "nat_cidr"