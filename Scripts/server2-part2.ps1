Install-WindowsFeature DNS -IncludeManagementTools

Add-DnsServerSecondaryZone -Name WS2-2425-Mattias.hogent -MasterServers 192.168.24.10 -ZoneFile WS2-2425-Mattias.hogent
Add-DnsServerSecondaryZone -NetworkID "192.168.24.0/24" -MasterServers 192.168.24.10 -ZoneFile 24.168.192.in-addr.arpa

New-NetFirewallRule -DisplayName "SQLServer default instance" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SQLServer Browser service" -Direction Inbound -LocalPort 1434 -Protocol UDP -Action Allow

Copy-Item C:\vagrant\en_sql_server_2019_standard_x64_dvd_814b57aa.iso C:\
Mount-DiskImage -ImagePath C:\en_sql_server_2019_standard_x64_dvd_814b57aa.iso
F:\setup.exe  /ConfigurationFile=C:\vagrant\ConfigurationFile.ini