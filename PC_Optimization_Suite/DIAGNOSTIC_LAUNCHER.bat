@echo off
REM ═══════════════════════════════════════════════════════════════════════════
REM DIAGNOSTIC LAUNCHER - DEBUG VERSION
REM Shows you exactly what's happening when you run the suite
REM ═══════════════════════════════════════════════════════════════════════════

setlocal enabledelayedexpansion
cd /d "%~dp0"

cls
color 0B
mode con: cols=100 lines=40

echo.
echo ╔══════════════════════════════════════════════════════════════════════════════════╗
echo ║                                                                                  ║
echo ║            DIAGNOSTIC LAUNCHER - TROUBLESHOOTING VERSION                        ║
echo ║                                                                                  ║
echo ║            This will show you EXACTLY what's happening                          ║
echo ║                                                                                  ║
echo ╚══════════════════════════════════════════════════════════════════════════════════╝
echo.

echo [CHECKING] Administrator Privileges...
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ❌ PROBLEM FOUND: You need to run this as ADMINISTRATOR!
    echo.
    echo HOW TO FIX:
    echo 1. Close this window
    echo 2. Right-click on: RUN_ME_FIRST_RYZEN.bat
    echo 3. Select: "Run as Administrator"
    echo 4. Click: Yes when Windows asks
    echo.
    echo ═══════════════════════════════════════════════════════════════════════════════════
    echo This is REQUIRED because the optimizations need admin access to modify system
    echo settings and registry files.
    echo ═══════════════════════════════════════════════════════════════════════════════════
    echo.
    pause
    exit /b 1
)

echo ✅ Administrator privileges: CONFIRMED

echo.
echo [CHECKING] Current Directory...
echo Current path: %~dp0
if exist "%~dp0" (
    echo ✅ Directory accessible
) else (
    echo ❌ Directory not accessible
    pause
    exit /b 1
)

echo.
echo [CHECKING] Optimization Scripts...
set /a scripts_found=0

if exist "%~dp01_SYSTEM_OPTIMIZER.bat" (
    echo ✅ 1_SYSTEM_OPTIMIZER.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 1_SYSTEM_OPTIMIZER.bat - NOT FOUND
)

if exist "%~dp02_GRAPHICS_OPTIMIZER.bat" (
    echo ✅ 2_GRAPHICS_OPTIMIZER.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 2_GRAPHICS_OPTIMIZER.bat - NOT FOUND
)

if exist "%~dp03_POWER_PLAN_OPTIMIZER_RYZEN.bat" (
    echo ✅ 3_POWER_PLAN_OPTIMIZER_RYZEN.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 3_POWER_PLAN_OPTIMIZER_RYZEN.bat - NOT FOUND
)

if exist "%~dp04_NETWORK_OPTIMIZER.bat" (
    echo ✅ 4_NETWORK_OPTIMIZER.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 4_NETWORK_OPTIMIZER.bat - NOT FOUND
)

if exist "%~dp05_STORAGE_MEMORY_OPTIMIZER_32GB.bat" (
    echo ✅ 5_STORAGE_MEMORY_OPTIMIZER_32GB.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 5_STORAGE_MEMORY_OPTIMIZER_32GB.bat - NOT FOUND
)

if exist "%~dp06_CPU_OPTIMIZER_RYZEN.bat" (
    echo ✅ 6_CPU_OPTIMIZER_RYZEN.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 6_CPU_OPTIMIZER_RYZEN.bat - NOT FOUND
)

if exist "%~dp07_ADVANCED_TWEAKS.bat" (
    echo ✅ 7_ADVANCED_TWEAKS.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 7_ADVANCED_TWEAKS.bat - NOT FOUND
)

if exist "%~dp08_GPU_MEMORY_OPTIMIZER_AMD.bat" (
    echo ✅ 8_GPU_MEMORY_OPTIMIZER_AMD.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 8_GPU_MEMORY_OPTIMIZER_AMD.bat - NOT FOUND
)

if exist "%~dp09_FINAL_CLEANUP.bat" (
    echo ✅ 9_FINAL_CLEANUP.bat - FOUND
    set /a scripts_found+=1
) else (
    echo ❌ 9_FINAL_CLEANUP.bat - NOT FOUND
)

echo.
echo [RESULT] Scripts found: %scripts_found%/9

if %scripts_found% equ 9 (
    echo ✅ All scripts present and accounted for!
    echo.
    echo ═══════════════════════════════════════════════════════════════════════════════════
    echo GOOD NEWS: Everything is ready to run!
    echo.
    echo Now running the optimization suite...
    echo ═══════════════════════════════════════════════════════════════════════════════════
    echo.
    timeout /t 3 /nobreak
    
    REM Now run the actual master launcher
    REM But keep this window open to show status
    echo.
    echo [STATUS] Starting optimization scripts...
    echo.
    
    REM Create log file
    set LOGFILE=%~dp0Optimization_Log_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt
    echo Optimization Log - %date% %time% > "%LOGFILE%"
    echo Starting optimization scripts >> "%LOGFILE%"
    echo. >> "%LOGFILE%"
    
    REM Create restore point
    echo [STEP 0/10] Creating System Restore Point...
    echo Creating restore point >> "%LOGFILE%"
    powershell -Command "Checkpoint-Computer -Description 'Before PC Optimization Suite' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
    echo ✅ Restore point created >> "%LOGFILE%"
    echo.
    
    REM Run each script and show status
    echo [STEP 1/9] Running SYSTEM OPTIMIZER...
    call "%~dp01_SYSTEM_OPTIMIZER.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 1 completed
    echo.
    
    echo [STEP 2/9] Running GRAPHICS OPTIMIZER...
    call "%~dp02_GRAPHICS_OPTIMIZER.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 2 completed
    echo.
    
    echo [STEP 3/9] Running POWER PLAN OPTIMIZER...
    call "%~dp03_POWER_PLAN_OPTIMIZER_RYZEN.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 3 completed
    echo.
    
    echo [STEP 4/9] Running NETWORK OPTIMIZER...
    call "%~dp04_NETWORK_OPTIMIZER.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 4 completed
    echo.
    
    echo [STEP 5/9] Running MEMORY OPTIMIZER...
    call "%~dp05_STORAGE_MEMORY_OPTIMIZER_32GB.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 5 completed
    echo.
    
    echo [STEP 6/9] Running CPU OPTIMIZER...
    call "%~dp06_CPU_OPTIMIZER_RYZEN.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 6 completed
    echo.
    
    echo [STEP 7/9] Running ADVANCED TWEAKS...
    call "%~dp07_ADVANCED_TWEAKS.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 7 completed
    echo.
    
    echo [STEP 8/9] Running GPU MEMORY OPTIMIZER...
    call "%~dp08_GPU_MEMORY_OPTIMIZER_AMD.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 8 completed
    echo.
    
    echo [STEP 9/9] Running FINAL CLEANUP...
    call "%~dp09_FINAL_CLEANUP.bat" >> "%LOGFILE%" 2>&1
    echo ✅ Script 9 completed
    echo.
    
    echo ═══════════════════════════════════════════════════════════════════════════════════
    echo ✅ ALL OPTIMIZATIONS COMPLETE!
    echo ═══════════════════════════════════════════════════════════════════════════════════
    echo.
    echo Log file saved to: "%LOGFILE%"
    echo.
    echo NEXT STEPS:
    echo 1. Restart your computer (important - changes take effect after restart)
    echo 2. Play Call of Duty
    echo 3. Check FPS (should be 60-75+ FPS)
    echo.
    pause
    
) else (
    echo.
    echo ❌ NOT ALL SCRIPTS FOUND!
    echo.
    echo PROBLEM: %scripts_found% scripts found, but we need 9
    echo.
    echo SOLUTION:
    echo Make sure all 9 optimization scripts are in the same folder as this launcher:
    echo.
    echo Location: %~dp0
    echo.
    echo Required files:
    echo   1_SYSTEM_OPTIMIZER.bat
    echo   2_GRAPHICS_OPTIMIZER.bat
    echo   3_POWER_PLAN_OPTIMIZER_RYZEN.bat
    echo   4_NETWORK_OPTIMIZER.bat
    echo   5_STORAGE_MEMORY_OPTIMIZER_32GB.bat
    echo   6_CPU_OPTIMIZER_RYZEN.bat
    echo   7_ADVANCED_TWEAKS.bat
    echo   8_GPU_MEMORY_OPTIMIZER_AMD.bat
    echo   9_FINAL_CLEANUP.bat
    echo.
    pause
)
