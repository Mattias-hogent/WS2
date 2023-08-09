
function updateWindows {
    $action = New-ScheduledTaskAction -Execute pwsh.exe -Argument "-File C:\Users\Admin\Documents\ssh-setup.ps1"
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    Register-ScheduledTask SSH_setup -Action $action -Trigger $trigger
}