Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"

Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\WinLogon' -Name Shell -Value 'C:\Program Files\PowerShell\7\pwsh.exe'

Start-Process 'C:\Program Files\PowerShell\7\pwsh.exe' -NoNewWindow

Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mattias-hogent/WS2/main/update.ps1 -OutFile "~\Documents\update.ps1"
Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mattias-hogent/WS2/main/ssh-setup.ps1 -OutFile "~\Documents\ssh-setup.ps1"

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# installs updates
Install-Module -Name PSWindowsUpdate -Force
Import-Module -Name PSWindowsUpdate

."~\Documents\update.ps1"
#Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -Install
#Get-WindowsUpdate -WindowsUpdate -AcceptAll -AutoReboot -Install