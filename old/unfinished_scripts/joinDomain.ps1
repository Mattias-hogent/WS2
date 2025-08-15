Import-Module Microsoft.PowerShell.Management -UseWindowsPowerShell

Add-Computer -ComputerName Exchange -LocalCredential Exchange\Administartor -DomainName WinServ2 -Credential WinServ2\Administartor -Restart -Force