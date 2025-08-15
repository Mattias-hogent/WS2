& powercfg /S e9a42b02-d5df-448d-aa00-03f14749eb61

Get-NetAdapter -InterfaceAlias Ethernet0 | Rename-NetAdapter -NewName Uplink
Get-NetAdapter -InterfaceAlias Ethernet1 | Rename-NetAdapter -NewName Downlink

Set-NetIPInterface -InterfaceAlias Downlink -InterfaceMetric 10

Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In"

Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" 'AutoAdminLogon' -Value "1" -Type String 
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" 'DefaultUsername' -Value "vagrant"-type String 
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" 'DefaultPassword' -Value "vagrant" -type String

$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'"
$adapters.SetDynamicDNSRegistration($true,$true)

Add-WindowsCapability -Online -Name "Rsat.ServerManager.Tools~~~~0.0.1.0"
Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"
Add-WindowsCapability -Online -Name "Rsat.CertificateServices.Tools~~~~0.0.1.0"
Add-WindowsCapability -Online -Name "Rsat.DHCP.Tools~~~~0.0.1.0"
Add-WindowsCapability -Online -Name "Rsat.Dns.Tools~~~~0.0.1.0"

Invoke-RestMethod https://aka.ms/ssms/21/release/vs_SSMS.exe -OutFile C:\Users\vagrant\Downloads\vs_SSMS.exe
Start-Process -FilePath C:\Users\vagrant\Downloads\vs_SSMS.exe -ArgumentList "--quiet --downloadThenInstall"