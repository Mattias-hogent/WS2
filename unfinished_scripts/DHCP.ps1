Install-WindowsFeature DHCP -IncludeManagementTools
Add-DhcpServerv4Scope -Name "Clients" -StartRange 192.168.0.150 -EndRange 192.168.0.250 -SubnetMask 255.255.255.0