@echo off
:: Made with ❤️ AK
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: ========================================================
:: 0. RAM Booster Admin Check
:: ========================================================
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    goto :START
) ELSE (
    echo Requesting Administrator privileges...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

:START
cls
color 1F
echo ========================================================
echo      Made with ❤️ AK
echo      ULTIMATE RAM BOOSTER & SYSTEM OPTIMIZER
echo ========================================================
echo.
echo [!] This will close browsers and background apps.
echo [!] Screen may flicker briefly.
echo.
pause

:: ========================================================
:: 1. ACTIVE RAM BOOSTER ENGINE (New Feature)
:: ========================================================
echo [-] Initializing RAM Booster Engine...

:: A. Enable "Always Unload DLL" (Frees RAM immediately after closing apps)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v AlwaysUnloadDll /t REG_DWORD /d 1 /f >nul 2>&1

:: B. Prioritize RAM for Apps instead of System Cache
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul 2>&1

:: C. Clear Clipboard Memory
echo off | clip

:: D. AGGRESSIVE WORKING SET TRIM (The "Magic" Command)
echo [-] FIring Memory Compression (Dropping RAM usage)...
powershell -command "$p = Get-Process; foreach($i in $p){try{$i.MinWorkingSet = [System.IntPtr]::Zero}catch{}}" >nul 2>&1

:: ========================================================
:: 2. KILL GENERIC RESOURCE HOGS
:: ========================================================
echo [-] Terminating common heavy background processes...
taskkill /F /IM chrome.exe /T >nul 2>&1
taskkill /F /IM msedge.exe /T >nul 2>&1
taskkill /F /IM firefox.exe /T >nul 2>&1
taskkill /F /IM brave.exe /T >nul 2>&1
taskkill /F /IM onedrive.exe /T >nul 2>&1
taskkill /F /IM teams.exe /T >nul 2>&1
taskkill /F /IM cortana.exe /T >nul 2>&1
taskkill /F /IM skype.exe /T >nul 2>&1
taskkill /F /IM steam.exe /T >nul 2>&1
taskkill /F /IM discord.exe /T >nul 2>&1
taskkill /F /IM spotify.exe /T >nul 2>&1
taskkill /F /IM phoneexperiencehost.exe /T >nul 2>&1
taskkill /F /IM "GameBar.exe" /T >nul 2>&1

:: ========================================================
:: 3. DISABLE STANDARD WINDOWS BLOAT SERVICES
:: ========================================================
echo [-] Optimizing Windows Services...

:: SysMain: Preloads apps into RAM. Disabling frees memory.
net stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1

:: DiagTrack: Windows Telemetry.
net stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1

:: Windows Search: Often causes high disk/RAM usage.
net stop WSearch >nul 2>&1
sc config WSearch start= manual >nul 2>&1

:: Xbox Live Services (Only needed when actively gaming)
net stop XblAuthManager >nul 2>&1
net stop XblGameSave >nul 2>&1
net stop XboxNetApiSvc >nul 2>&1

:: ========================================================
:: 4. DEEP CLEAN (Temp, Caches, Thumbnails)
:: ========================================================
echo [-] Cleaning System & User Temp Files...
del /q /f /s "%TEMP%\*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1

echo [-] Flushing Network & DNS...
ipconfig /flushdns >nul

echo [-] Cleaning Icon & Thumbnail Cache...
taskkill /f /im explorer.exe >nul 2>&1
cd /d "%LocalAppData%\Microsoft\Windows\Explorer"
del /f /q thumbcache_*.db >nul 2>&1
del /f /q iconcache_*.db >nul 2>&1

:: ========================================================
:: 5. RESET STARTUP FOLDER (User Only)
:: ========================================================
echo [-] Clearing User Startup Folder...
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*" >nul 2>&1

:: ========================================================
:: 6. ENABLE FAST BOOT & RESTART INTERFACE
:: ========================================================
echo [-] Enabling Fast Boot...
powercfg /hibernate on
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 1 /f >nul 2>&1

echo [-] Restarting Windows Explorer...
start explorer.exe

:: ========================================================
:: 7. FINAL RAM TRIM (Double Check)
:: ========================================================
echo [-] Finalizing Memory Boost...
powershell -command "$p = Get-Process; foreach($i in $p){try{$i.MinWorkingSet = [System.IntPtr]::Zero}catch{}}" >nul 2>&1

echo.
echo ========================================================
echo      OPTIMIZATION COMPLETE.
echo      Made with ❤️ AK
echo ========================================================
pause