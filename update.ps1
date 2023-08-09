$update = Get-WindowsUpdate -WindowsUpdate
$updateCount = $update.Count

while ($updateCount -gt 1) {
    updateWindows
}
else {
    Write-Host "Updates complete"
}

function updateWindows {
    $action = New-ScheduledTaskAction -Execute "C:\Program Files\PowerShell\7\pwsh.exe" -Argument "-file ~\Documents\update.ps1"
    $trigger = New-ScheduledTaskTrigger -AtLogon
    $principal = "SERVER\Admin"
    $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger
    Register-ScheduledTask T1 -InputObject $task
    Get-WindowsUpdate -WindowsUpdate -AcceptAll -AutoReboot -Install
}


