Invoke-RestMethod https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0fd66638cde16859462a6243a4629a50/ndp48-x86-x64-allos-enu.exe -OutFile dotnet_4.8.exe

Invoke-RestMethod https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe -OutFile VC++_2012.exe

.\dotnet_4.8.exe /q /norestart /log "$Env:windir\Temp\DotNET48-Install.log"

.\VC++.exe /Q