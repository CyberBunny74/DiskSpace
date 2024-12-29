# Define the output file path
$outputFile = "C:\CSVReports\DiskDrives.csv"

# Remove the existing output file if it exists
if (Test-Path $outputFile) {
    Remove-Item $outputFile
}

# Use a StreamReader to read the servers file
$reader = [System.IO.StreamReader]::new("C:\scripts\servers.txt")

# Process servers in batches
$batchSize = 10
$batch = @()

while ($true) {
    $server = $reader.ReadLine()
    if ($server -eq $null) {
        # Process remaining servers in the last batch
        if ($batch.Count -gt 0) {
            $results = Invoke-Command -ComputerName $batch -ScriptBlock {
                Get-CimInstance Win32_LogicalDisk -Filter "Drivetype=3" |
                Select-Object @{Name='SystemName';Expression={$env:COMPUTERNAME}},
                              DeviceID,
                              @{Name='Size(GB)';Expression={[int]($_.Size / 1GB)}}
            }
            $results | Export-Csv $outputFile -Append -NoTypeInformation
        }
        break
    }

    $batch += $server

    if ($batch.Count -eq $batchSize) {
        $results = Invoke-Command -ComputerName $batch -ScriptBlock {
            Get-CimInstance Win32_LogicalDisk -Filter "Drivetype=3" |
            Select-Object @{Name='SystemName';Expression={$env:COMPUTERNAME}},
                          DeviceID,
                          @{Name='Size(GB)';Expression={[int]($_.Size / 1GB)}}
        }
        $results | Export-Csv $outputFile -Append -NoTypeInformation
        $batch = @()
    }
}

$reader.Close()

Write-Host "Disk information has been exported to $outputFile"
