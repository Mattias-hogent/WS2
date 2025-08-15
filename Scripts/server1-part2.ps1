Install-WindowsFeature -name AD-Domain-Services
Import-Module ADDSDeployment

$PWord = ConvertTo-SecureString -AsPlainText "24Admin25" -Force

$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "C:\vagrant\Scripts\server1-part3.ps1")


Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "WS2-2425-Mattias.hogent" `
-DomainNetbiosName "WINSERV2" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true `
-SafeModeAdministratorPassword $PWord