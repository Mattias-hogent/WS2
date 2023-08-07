Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"

Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\WinLogon' -Name Shell -Value 'C:\Program Files\PowerShell\7\pwsh.exe'

Write-Host $env:USERNAME
Write-Host "$([System.Environment]::GetFolderPath('Startup'))\ssh-setup.ps1"
Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mattias-hogent/WS2/main/ssh-setup.ps1 -OutFile "C:\Users\Admin\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ssh-setup.ps1"

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -ErrorAction Continue

# installs updates
Install-Module -Name PSWindowsUpdate -Force
Import-Module -Name PSWindowsUpdate
Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot -Install