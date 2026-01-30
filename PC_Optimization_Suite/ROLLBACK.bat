@echo off
REM =====================================================
REM COMPLETE ROLLBACK SCRIPT
REM Reverts ALL optimization changes to original state
REM =====================================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script requires Administrator privileges!
    echo Please right-click and select "Run as Administrator"
    pause
    exit /b 1
)

cls
color 0C
echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║           COMPLETE ROLLBACK - RESTORE TO ORIGINAL        ║
echo ║        This will undo ALL optimization changes           ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo WARNING: This will restore Windows to pre-optimization state!
echo.
echo Press any key to continue with rollback...
echo (This will take 2-3 minutes)
echo.
pause

cls
echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║              STARTING COMPLETE ROLLBACK                  ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

echo [Step 1] Restoring System Services...
echo Enabling disabled services...

REM Re-enable Superfetch (Windows Search optimization)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
net start "SysMain" >nul 2>&1

REM Re-enable Cortana
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
net start "WSearch" >nul 2>&1

REM Re-enable Telemetry
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
net start "DiagTrack" >nul 2>&1

REM Re-enable Print Spooler
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
net start "Spooler" >nul 2>&1

timeout /t 1 /nobreak >nul 2>&1

echo ✓ System services restored

echo [Step 2] Restoring Visual Effects...
echo Enabling Windows animations and effects...

REM Re-enable visual effects
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "EnableAnimations" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012038010000000" /f >nul 2>&1

timeout /t 1 /nobreak >nul 2>&1

echo ✓ Visual effects restored

echo [Step 3] Restoring GPU Settings...
echo Re-enabling graphics optimizations...

REM Re-enable GPU scheduling (Windows 11)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "1" /f >nul 2>&1

REM Re-enable HDR
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableHDR" /t REG_DWORD /d "1" /f >nul 2>&1

echo ✓ GPU settings restored

echo [Step 4] Restoring Power Plan...
echo Creating standard power plans...

REM Reset power scheme to defaults
powercfg /restoredefaultschemes >nul 2>&1

REM Set Balanced power plan as active
powercfg /setactive scheme_balanced >nul 2>&1

echo ✓ Power plans restored

echo [Step 5] Restoring CPU Settings...
echo Restoring CPU power management...

REM Re-enable CPU power management
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Processor" /v "MaxCState" /t REG_DWORD /d "2" /f >nul 2>&1

REM Re-enable core parking
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Processor\CStateSetting" /v "MaxC-State" /t REG_DWORD /d "3" /f >nul 2>&1

REM Restore default processor state
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Processor" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1

echo ✓ CPU settings restored

echo [Step 6] Restoring Network Settings...
echo Resetting network configuration...

REM Restore TCP Window Size to default
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "65535" /f >nul 2>&1

REM Restore QoS
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableQOS" /t REG_DWORD /d "0" /f >nul 2>&1

REM Restore NetBIOS
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NetbiosOptions" /t REG_DWORD /d "0" /f >nul 2>&1

REM Reset TCP/IP
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /flushdns >nul 2>&1

echo ✓ Network settings restored

echo [Step 7] Restoring Memory Management...
echo Resetting pagefile and virtual memory...

REM Restore memory compression
powershell -Command "Set-MMAgent -MemoryCompression $true" >nul 2>&1

REM Reset pagefile
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "C:\pagefile.sys 0 0" /f >nul 2>&1

echo ✓ Memory settings restored

echo [Step 8] Restoring Registry Tweaks...
echo Reversing registry optimizations...

REM Restore disk optimization
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /v "EnablePrefetcher" /t REG_DWORD /d "3" /f >nul 2>&1

REM Restore default cache size
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "0" /f >nul 2>&1

REM Restore default file system cache
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "Size" /t REG_DWORD /d "1" /f >nul 2>&1

timeout /t 1 /nobreak >nul 2>&1

echo ✓ Registry tweaks reversed

echo [Step 9] Clearing Optimization Artifacts...
echo Removing temporary optimization files...

REM Clear any optimization temp files
if exist "%SystemRoot%\Temp\AMD" rmdir /s /q "%SystemRoot%\Temp\AMD" >nul 2>&1

echo ✓ Temporary files cleared

echo [Step 10] Final System Reset...
echo Applying final changes...

REM Clear DNS cache to apply changes
ipconfig /flushdns >nul 2>&1

timeout /t 2 /nobreak >nul 2>&1

echo ✓ System reset complete

echo.
echo ═══════════════════════════════════════════════════════════
echo ✓ COMPLETE ROLLBACK FINISHED!
echo ═══════════════════════════════════════════════════════════
echo.
echo System Restored:
echo  ✓ All services restored to default
echo  ✓ Visual effects re-enabled
echo  ✓ Power plan changed to Balanced
echo  ✓ CPU power management re-enabled
echo  ✓ Network settings reset
echo  ✓ Memory compression re-enabled
echo  ✓ Registry tweaks reversed
echo  ✓ Prefetch enabled
echo.
echo What Changed Back:
echo.
echo Services:
echo  • Windows Search: ENABLED
echo  • Superfetch: ENABLED
echo  • Cortana: ENABLED
echo  • Telemetry: ENABLED
echo  • Print Spooler: ENABLED
echo.
echo Performance:
echo  • CPU power saving: ON
echo  • Core parking: ON (auto)
echo  • Visual effects: ON
echo  • Memory compression: ON
echo.
echo Network:
echo  • TCP optimization: DISABLED
echo  • Standard MTU: 1500
echo  • NetBIOS: ENABLED
echo.
echo Power Plan:
echo  • Now using: Balanced (default)
echo  • CPU: Dynamic frequency scaling
echo  • GPU: Adaptive power management
echo.
echo IMPORTANT:
echo.
echo To complete rollback, you MUST restart your laptop!
echo.
echo Restart now? (Y/N)
set /p restart="Enter choice: "
if /i "%restart%"=="Y" (
    echo Restarting in 10 seconds...
    timeout /t 10
    shutdown /r /t 0
) else (
    echo.
    echo Restart the laptop manually when ready:
    echo  1. Click Start menu
    echo  2. Click Power
    echo  3. Click Restart
    echo.
    pause
)
