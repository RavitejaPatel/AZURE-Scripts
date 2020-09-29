$TimeSpan = New-TimeSpan -Minutes 1
$EndTime = (Get-Date).AddMinutes($TimeSpan.TotalMinutes).ToString("HH:mm")

## START TIMED LOOP
cls
do
{
## START YOUR SCRIPT
Write-Warning "Test-Job 1...2...3..."
Start-Sleep 3
Write-Warning "End Time = $EndTime`n"
}
until ($EndTime -eq (Get-Date -Format HH:mm))

## TIME REACHED AND END SCRIPT
Write-Host "End Time reached!" -ForegroundColor Green