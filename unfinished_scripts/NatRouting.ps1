Install-WindowsFeature Routing -IncludeManagementTools

New-NetNat -Name winserv2 -InternalIPInterfaceAddressPrefix 192.168.0.0/24