Get-NetAdapter -InterfaceAlias Ethernet0 | New-NetIPAddress -IPAddress 192.168.24.11 -PrefixLength 24
Get-NetAdapter -InterfaceAlias Ethernet0 | Rename-NetAdapter -NewName Uplink
Get-NetAdapter -InterfaceAlias Ethernet1 | Rename-NetAdapter -NewName Downlink

set-dnsClientServerAddress -InterfaceAlias Downlink -ServerAddresses 192.168.24.10

Set-NetIPInterface -InterfaceAlias Downlink -InterfaceMetric 10

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name 'ForceAutoLogon'-Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name 'AutoAdminLogon' -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name 'DefaultUsername' -Value "vagrant" -type String 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name 'DefaultPassword' -Value "vagrant" -type String

$User = "winserv2\vagrant"
$PWord = ConvertTo-SecureString -AsPlainText "24Admin25" -Force
$credentialParams = @{
    TypeName = 'System.Management.Automation.PSCredential'
    ArgumentList = $User, $PWord
}

Add-Computer -DomainName WS2-2425-Mattias.hogent -Verbose -Credential $credentialParams

$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "C:\vagrant\Scripts\server2-part2.ps1")
Restart-Computer