$update = Get-WindowsUpdate -WindowsUpdate
$updateCount = $update.Count

while ($updateCount -gt 1) {
    updateWindows
}
else {
    Write-Host "Updates complete"
}

function updateWindows {
    $trigger = New-JobTrigger -AtLogOn -User SERVER\Admin
    Register-ScheduledJob -Name "updateWindows" -FilePath "~\Documents\update.ps1" -Trigger $trigger
}