Add-ADGroupMember -Identity "Domain Admins" -Members vagrant

$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "C:\vagrant\Scripts\server1-part4.ps1")

Restart-Computer