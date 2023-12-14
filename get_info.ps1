# Collect Processor Information
$processor = Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty Name

# Collect Installed Memory Size
$mem = Get-WmiObject -Class Win32_PhysicalMemory |
       Measure-Object -Property Capacity -Sum |
       % { [Math]::Round($_.Sum / 1GB, 2) }
$memory = "${mem}GB"

# Collect OS Information
$os = Get-WmiObject -Class Win32_OperatingSystem |
      Select-Object -Property Caption, OSArchitecture, BuildNumber |
      % { "$($_.Caption) build $($_.BuildNumber), $($_.OSArchitecture)" }

# Collect Vagrant Version
try {
    $vagrantVersion = vagrant --version
} catch {
    $vagrantVersion = "Vagrant not installed or not in PATH"
}

# Collect VirtualBox Version
try {
    $virtualBoxVersion = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*' |
                          Where-Object { $_.DisplayName -like '*VirtualBox*' }).DisplayVersion
} catch {
    $virtualBoxVersion = "VirtualBox not installed or version not found"
}

# Define the default installation path for VirtualBox
$virtualBoxPath = "C:\Program Files\Oracle\VirtualBox"

# Define the name of the Guest Additions ISO
$guestAdditionsISO = "VBoxGuestAdditions.iso"

# Construct the full path to the ISO
$isoPath = Join-Path -Path $virtualBoxPath -ChildPath $guestAdditionsISO

# Attempt to get Guest Additions Version
try {
    $mountedISO = Mount-DiskImage -ImagePath $isoPath -PassThru -ErrorAction SilentlyContinue
    if ($mountedISO) {
        $driveLetter = ($mountedISO | Get-Volume).DriveLetter
        $additionsFilePath = "$($driveLetter):\VBoxLinuxAdditions.run"
        if (Test-Path -Path $additionsFilePath) {
            $additionsFileContent = Get-Content -Path $additionsFilePath
            $versionLine = $additionsFileContent | Where-Object { $_ -match "label=" }
            if ($versionLine -ne $null) {
                $version = $versionLine.Split("=")[1].Trim('"')
                $guestAdditionsVersion = $version -replace ' Guest Additions for Linux', ' Guest Additions'
            } else {
                $guestAdditionsVersion = "Unknown"
            }
        } else {
            $guestAdditionsVersion = "Unable to locate VBoxLinuxAdditions.run to determine the version."
        }
        Dismount-DiskImage -ImagePath $isoPath
    } else {
        $guestAdditionsVersion = "Failed to mount the Guest Additions ISO."
    }
} catch {
    $guestAdditionsVersion = "Error in obtaining Guest Additions version."
}

# Output the Collected Information
Write-Host "Processor: $processor"
Write-Host "Installed Memory: $memory"
Write-Host "OS Information: $os"
Write-Host "Vagrant Version: $vagrantVersion"
Write-Host "VirtualBox Version: $virtualBoxVersion"
Write-Host "VirtualBox Guest Additions Version: $guestAdditionsVersion"