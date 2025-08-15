Get-NetAdapter | Get-NetIPAddress -AddressFamily IPv4 | Where-Object -Property IPv4Address -NE 10.0.2.15 | New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24

Get-NetAdapter | Get-NetIPAddress -AddressFamily IPv4 | Where-Object -Property IPv4Address -NE 10.0.2.15 | Get-NetAdapter | Rename-NetAdapter -NewName Internal

Get-NetAdapter | Get-NetIPAddress -AddressFamily IPv4 | Where-Object -Property IPv4Address -EQ 10.0.2.15 | Get-NetAdapter | Rename-NetAdapter -NewName External