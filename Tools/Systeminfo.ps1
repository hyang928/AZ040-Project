$computer = "LON-DC1"
$os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer

$cDrive = get-ciminstance -ClassName Win32_LogicalDisk -ComputerName $computer -Filter "DeviceID='C:'"

$uptime =  $os.LocalDateTime - $os.LastBootUpTime

$info = [PSCustomObject]@{
    ComputerName = $computer
    OS = $os.caption
    LastBootUpTime = $os.LastBootUpTime
    CDriveSize = $cDrive.Size
    CDriveFreeSpace = $cDrive.FreeSpace
    CDriveFreeSpaceGB = [math]::Round(($cDrive.FreeSpace / 1GB), 2)
    UptimeHours = [math]::Round($uptime.TotalHours, 2)
}
$info 