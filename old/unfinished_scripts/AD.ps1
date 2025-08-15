Install-WindowsFeature -name AD-Domain-Services

Import-Module ADDSDeployment

# TODO automate credentials
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "WinServ2.local" `
-DomainNetbiosName "WINSERV2" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

# restart needed

Install-WindowsFeature DHCP -IncludeManagementTools

Add-DhcpServerInDC -DnsName DHCP-GUI.WinServ2GUI.local -IPAddress 192.168.0.2

Remove-WindowsFeature DHCP -IncludeManagementTools