# Get-NetAdapter | Get-NetIPAddress -AddressFamily IPv4 | Where-Object -Property IPv4Address -NE 10.0.2.15 | New-NetIPAddress -IPAddress 192.168.24.10 -PrefixLength 24

# Get-NetAdapter | Get-NetIPAddress -AddressFamily IPv4 | Where-Object -Property IPv4Address -EQ 10.0.2.15 | Get-NetAdapter | Rename-NetAdapter -NewName Uplink

# Get-NetAdapter | Get-NetIPAddress -AddressFamily IPv4 | Where-Object -Property IPv4Address -NE 10.0.2.15 | Get-NetAdapter | Rename-NetAdapter -NewName Downlink

Get-NetAdapter -InterfaceAlias Ethernet1 | New-NetIPAddress -IPAddress 192.168.24.10 -PrefixLength 24
Get-NetAdapter -InterfaceAlias Ethernet0 | Rename-NetAdapter -NewName Uplink
Get-NetAdapter -InterfaceAlias Ethernet1 | Rename-NetAdapter -NewName Downlink

set-dnsClientServerAddress -InterfaceAlias Downlink -ServerAddresses 192.168.24.10
Set-NetIPInterface -InterfaceAlias Downlink -InterfaceMetric 10

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name 'ForceAutoLogon'-Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name 'AutoAdminLogon' -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name 'DefaultUsername' -Value "vagrant" -type String 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name 'DefaultPassword' -Value "vagrant" -type String

Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In"

$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "C:\vagrant\Scripts\server1-part2.ps1")

& shutdown /r /t 10