Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"

Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\WinLogon' -Name Shell -Value 'C:\Program Files\PowerShell\7\pwsh.exe'

Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mattias-hogent/WS2/main/ssh-setup.ps1 -OutFile "$([Environment]::GetFolderPath('Startup'))\ssh-setup.ps1"

# installs updates
Install-Module -Name PSWindowsUpdate -Force
Import-Module -Name PSWindowsUpdate -Force
Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot -Install -Force