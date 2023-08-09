
function updateWindows {
    $action = New-ScheduledTaskAction -Execute "C:\Program Files\PowerShell\7\pwsh.exe" -Argument "-file ~\Documents\ssh-setup.ps1"
    $trigger = New-ScheduledTaskTrigger -AtStartup
    $task = New-ScheduledTask -Action $action -Trigger $trigger
    Register-ScheduledTask T1 -InputObject $task
}