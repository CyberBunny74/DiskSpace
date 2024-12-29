# Multi-Server Disk Space Query Script

## Description

This PowerShell script efficiently queries multiple servers for disk space information and exports the results to a CSV file. It's designed for performance, using parallel processing and batch operations to handle large numbers of servers quickly.

## Features

- Reads server names from a text file
- Processes servers in batches for improved performance
- Uses CIM instances for faster querying
- Exports results to a CSV file in real-time
- Handles large numbers of servers efficiently

## Requirements

- PowerShell 5.1 or later
- Remote management enabled on target servers
- Appropriate permissions to query disk information on remote servers

## Usage

1. Create a text file named `servers.txt` in the `C:\scripts\` directory, with one server name per line.
2. Run the script in PowerShell with administrator privileges.
3. The results will be exported to `C:\CSVReports\DiskDrives.csv`.

## Configuration

You can modify the following variables in the script:

- `$outputFile`: Change the path and name of the output CSV file
- `$batchSize`: Adjust the number of servers processed in each batch

## Output

The script generates a CSV file with the following columns:

- SystemName: The name of the server
- DeviceID: The drive letter
- Size(GB): The size of the drive in gigabytes (rounded to the nearest integer)

## Notes

- The script will overwrite the existing CSV file if it already exists.
- Ensure you have the necessary permissions to read from `C:\scripts\servers.txt` and write to the output directory.

## Troubleshooting

- If you encounter permission issues, ensure you're running PowerShell as an administrator.
- For remote execution problems, check that WinRM is properly configured on both the local and remote machines.

## Contributing

Feel free to fork this repository and submit pull requests for any enhancements.

## License

This script is released under the MIT License. See the LICENSE file for details.
