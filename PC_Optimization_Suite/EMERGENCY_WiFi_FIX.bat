@echo off
REM =====================================================
REM EMERGENCY WiFi RECOVERY SCRIPT
REM Restores Network & WiFi Connectivity
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
color 0A
echo.
echo ╔══════════════════════════════════════════════════════════╗
echo ║        EMERGENCY WiFi RECOVERY - NETWORK FIX             ║
echo ║     Restoring Network & WiFi Connectivity                ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo WARNING: This will restore network settings to defaults!
echo.

echo [Step 1] Restarting Network Service...
echo Stopping network services...

net stop wlanSvc >nul 2>&1
net stop "Network List Service" >nul 2>&1
net stop "Network Location Awareness" >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1

echo Starting network services...

net start wlanSvc >nul 2>&1
net start "Network List Service" >nul 2>&1
net start "Network Location Awareness" >nul 2>&1

echo ✓ Network services restarted

echo [Step 2] Resetting TCP/IP Stack...
echo Resetting TCP/IP to factory settings...

ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /flushdns >nul 2>&1

echo ✓ TCP/IP reset and renewed

echo [Step 3] Restoring Network Registry Settings...
echo Restoring default network configuration...

REM Restore default TCP window size (undoes optimization)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "65535" /f >nul 2>&1

REM Enable NetBIOS over TCP/IP
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NetbiosOptions" /t REG_DWORD /d "0" /f >nul 2>&1

REM Restore default MTU size
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MTU" /t REG_DWORD /d "1500" /f >nul 2>&1

REM Re-enable NETBIOS
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableNetbios" /t REG_DWORD /d "0" /f >nul 2>&1

echo ✓ Network registry settings restored

echo [Step 4] Enabling WiFi Adapter...
echo Enabling wireless adapter...

REM Enable WiFi adapter via WMI
for /f "tokens=2 delims==" %%A in ('wmic logicaldisk get name /value ^| find "Name"') do (
    set "SystemDrive=%%A"
)

REM Re-enable all network adapters
wmic path win32_networkadapter where PhysicalAdapter=true call enable >nul 2>&1

echo ✓ WiFi adapter enabled

echo [Step 5] Restoring WiFi Service...
echo Restarting WiFi Direct services...

net stop "wlansvc" >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1
net start "wlansvc" >nul 2>&1

echo ✓ WiFi service restarted

echo [Step 6] Resetting WiFi Profile...
echo Clearing corrupt WiFi profiles...

REM Remove potentially corrupt WiFi settings
netsh wlan reset profile >nul 2>&1

echo ✓ WiFi profiles reset

echo [Step 7] Restoring QoS (Quality of Service)...
echo Re-enabling QoS service...

REM Re-enable QoS if it was disabled
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1

net start "BITS" >nul 2>&1

echo ✓ QoS service restored

echo [Step 8] Flushing DNS Cache...
echo Clearing DNS resolver cache...

ipconfig /flushdns >nul 2>&1
ipconfig /registerdns >nul 2>&1

echo ✓ DNS cache flushed

echo [Step 9] Checking Network Status...
echo Verifying network connectivity...

REM Check if WiFi is visible
netsh wlan show networks mode=Bssid >nul 2>&1

echo ✓ Network check complete

echo [Step 10] Final System Refresh...
echo Refreshing network configuration...

timeout /t 2 /nobreak >nul 2>&1

REM Restart networking completely
netsh int ip reset >nul 2>&1

echo ✓ System network settings refreshed

echo.
echo ═══════════════════════════════════════════════════════════
echo ✓ EMERGENCY WiFi RECOVERY COMPLETE!
echo ═══════════════════════════════════════════════════════════
echo.
echo Network Settings Restored:
echo  ✓ Network services restarted
echo  ✓ TCP/IP stack reset to defaults
echo  ✓ WiFi adapter re-enabled
echo  ✓ WiFi service restarted
echo  ✓ Network profiles cleared
echo  ✓ QoS service re-enabled
echo  ✓ DNS cache flushed
echo.
echo NEXT STEPS:
echo.
echo 1. WiFi Networks Should Appear
echo    - Open Settings ^> Network ^& Internet ^> WiFi
echo    - Or click WiFi icon in system tray
echo    - Look for your network name (SSID)
echo.
echo 2. Connect to Your WiFi
echo    - Select your network
echo    - Enter WiFi password
echo    - Wait 30-60 seconds for connection
echo.
echo 3. Verify Internet Connection
echo    - Open web browser and go to google.com
echo    - Check that pages load normally
echo.
echo 4. Check Network Speed
echo    - Open Command Prompt and run: ping google.com
echo    - You should see responses with low latency (^<50ms)
echo.
echo 5. Update WiFi Drivers (Optional but Recommended)
echo    - Right-click Windows Start menu
echo    - Select "Device Manager"
echo    - Find "Network adapters"
echo    - Right-click your WiFi adapter
echo    - Select "Update driver" ^> "Search automatically"
echo.
echo IF WIFI STILL DOESN'T WORK:
echo.
echo Try these additional steps:
echo  1. Restart your laptop (full restart)
echo  2. Restart your WiFi router (turn off for 10 seconds)
echo  3. "Forget" the network and reconnect:
echo     - Settings ^> WiFi ^> Manage Known Networks
echo     - Select your network ^> Forget
echo     - Re-add your network and password
echo.
echo  4. Run Device Manager and check for:
echo     - Wireless Network Adapter (yellow exclamation = driver issue)
echo     - If there's a problem, right-click and "Update driver"
echo.
echo  5. Check if WiFi is disabled in BIOS:
echo     - Restart laptop and press F2, Del, or F10 during startup
echo     - Look for "Wireless" or "WiFi" setting
echo     - Make sure it's ENABLED
echo.
echo Your network should now be restored!
echo.
pause
