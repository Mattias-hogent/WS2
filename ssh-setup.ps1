$Task = "Update_windows"
$timeout = 60 ##  seconds
$timer = [Diagnostics.Stopwatch]::StartNew()

Start-Sleep -Seconds  30

while (((Get-ScheduledTask -TaskName $Task).State -ne 'Ready') -and ($timer.Elapsed.TotalSeconds -lt $timeout)) {    
    Write-Verbose  -Message "Waiting on scheduled task..."
    Start-Sleep -Seconds  10
}
$timer.Stop()

Write-Verbose  -Message "We waited [$($timer.Elapsed.TotalSeconds)] seconds on the task 'TaskName'"

# installs openssh server
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*' | Add-WindowsCapability -Online

# starts openssh server and sets it to start on startup
Get-Service | Where-Object Name -Like "sshd" | Set-Service -StartupType Automatic
Get-Service | Where-Object Name -Like "sshd" | Start-Service

# sets ssh default shell to default powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

# sets ssh default shell to powershell version 7
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

#Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\ssh-setup.ps1" -Force