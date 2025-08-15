Install-WindowsFeature DHCP -IncludeManagementTools

Add-DhcpServerInDC
Set-DhcpServerv4DnsSetting -DynamicUpdates "Always"
Add-DhcpServerv4Scope -Name "Clients" -StartRange 192.168.24.101 -EndRange 192.168.24.200 -SubnetMask 255.255.255.0
Add-DhcpServerv4ExclusionRange -ScopeId 192.168.24.0 -StartRange 192.168.24.151 -EndRange 192.168.24.200
Set-DhcpServerv4OptionValue -DnsServer 192.168.24.10, 192.168.24.11 -DnsDomain WS2-2425-Mattias.hogent -Force

Install-WindowsFeature DNS -IncludeManagementTools

Add-DnsServerPrimaryZone -NetworkID "192.168.24.0/24" -ReplicationScope "Forest"
Set-DnsServerPrimaryZone -Name WS2-2425-Mattias.hogent -Notify Notify -SecondaryServers 192.168.24.11 -SecureSecondaries TransferToSecureServers
Set-DnsServerPrimaryZone -Name 24.168.192.in-addr.arpa -Notify Notify -SecondaryServers 192.168.24.11 -SecureSecondaries TransferToSecureServers

Install-WindowsFeature AD-Certificate
Install-AdcsCertificationAuthority -CAType EnterpriseRootCA -Force

Install-WindowsFeature Adcs-Web-Enrollment
Install-AdcsWebEnrollment