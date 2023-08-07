Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"

Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\WinLogon' -Name Shell -Value 'C:\Program Files\PowerShell\7\pwsh.exe'

New-Item -Path C:\temp\log.txt -Force

Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mattias-hogent/WS2/main/ssh-setup.ps1 -OutFile "$([Environment]::GetFolderPath('Startup'))\ssh-setup.ps1" -ErrorAction Continue
$Error | Out-File c:\temp\log.txt -Append

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -ErrorAction Continue
$Error | Out-File c:\temp\log.txt -Append

# installs updates
Install-Module -Name PSWindowsUpdate -AcceptLicense -Force
Import-Module -Name PSWindowsUpdate
Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot -Install