$system = Get-CimInstance -ClassName Win32_ComputerSystem | select-object Name,Manufacturer,Model,Domain
$system = Get-CimInstance -ClassName Win32_ComputerSystem
$system
$system.Name
$system.Manufacturer
$system.Model
$system.Domain
$system | select-object Name,Model
$system | get-member -MemberType Property
$system.NumberOfLogicalProcessors

$computerReport = $system | select-object Name,Manufacturer,Model,Domain,NumberOfLogicalProcessors
$computerReport

$bios = get-ciminstance -ClassName Win32_BIOS
$bios
$bios.Manufacturer
$bios.SMBIOSBIOSVersion
$bios.SerialNumber

$biosReport = $bios | select-object Manufacturer,SMBIOSBIOSVersion,SerialNumber
$biosReport

$reportProperties = @{
    ComputerName      = $system.Name
    Manufacturer      = $system.Manufacturer
    Model             = $system.Model
    Domain            = $system.Domain
    LogicalProcessors = $system.NumberOfLogicalProcessors
    BIOSManufacturer  = $bios.Manufacturer
    BIOSVersion       = $bios.SMBIOSBIOSVersion
    SerialNumber      = $bios.SerialNumber
    BIOSReleaseDate    = $bios.ReleaseDate
}
$reportProperties
$reportProperties['computername']

$adminReport = [PSCustomObject]$reportProperties
$adminReport
$adminReport | gm -MemberType NoteProperty
$adminReport.ComputerName
$adminReport | select-object ComputerName,Manufacturer,Model,BIOSVersion

$reportFolder = $env:USERPROFILE
$reportFolder

$adminReport | Export-Csv -Path "$reportFolder\AdminReport.csv" -NoTypeInformation
Import-csv "$reportFolder\AdminReport.csv"

$adminReport | select-object Domain,ComputerName
$bios | get-member -p