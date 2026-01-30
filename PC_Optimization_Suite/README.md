# 🚀 PC Optimization Suite for Low-Mid End Gaming

**Ultimate Gaming Optimization for iGPU Laptops**

This comprehensive optimization suite is designed specifically for low-to-mid-end laptops with integrated GPUs (Intel HD Graphics, Radeon Graphics, etc.).

## 📊 Expected Results
- **Before:** 40 FPS (Call of Duty at lowest settings)
- **Target:** 50+ FPS
- **Dream Goal:** 60-70 FPS

## 📁 What's Included

### 1. **Main Optimizer** (`RUN_ME_FIRST.bat`)
   - Master optimization script that runs everything in sequence
   - Creates system restore points before optimization
   - Includes rollback options

### 2. **System Optimizations** (`1_SYSTEM_OPTIMIZER.bat`)
   - Disables visual effects and animations
   - Optimizes Windows services
   - Disables unnecessary background processes
   - Cleans temporary files

### 3. **Graphics & Gaming** (`2_GRAPHICS_OPTIMIZER.bat`)
   - GPU driver optimization
   - DirectX & graphics API tweaks
   - Game-specific settings
   - VRAM allocation optimization

### 4. **Performance Power Plan** (`3_POWER_PLAN_OPTIMIZER.bat`)
   - Creates "Ultimate Gaming" power plan
   - Maximizes CPU performance
   - Enables high-performance GPU mode

### 5. **Network Optimization** (`4_NETWORK_OPTIMIZER.bat`)
   - Reduces ping and latency
   - Disables network throttling
   - Optimizes TCP/IP settings

### 6. **Storage & Memory** (`5_STORAGE_MEMORY_OPTIMIZER.bat`)
   - Cleans junk files
   - Optimizes SSD/HDD
   - Manages virtual memory
   - Empties cache

### 7. **CPU Optimization** (`6_CPU_OPTIMIZER.bat`)
   - Allocates all CPU cores to gaming
   - Disables power management
   - Optimizes thread scheduling

### 8. **Advanced Tweaks** (`7_ADVANCED_TWEAKS.bat`)
   - Registry optimizations
   - DirectX cache clearing
   - Shader cache optimization
   - Audio latency reduction

### 9. **GPU Memory Boost** (`8_GPU_MEMORY_OPTIMIZER.bat`)
   - Increases shared VRAM allocation
   - Optimizes memory bandwidth
   - Reduces memory latency

### 10. **Final Cleanup** (`9_FINAL_CLEANUP.bat`)
   - Removes temporary files
   - Clears caches
   - Optimizes disk
   - Final defragmentation

### 11. **Game Settings Generator** (`GAME_SETTINGS.bat`)
   - Generates optimal game settings for CoD
   - Creates .cfg files for maximum FPS

### 12. **Rollback Script** (`ROLLBACK.bat`)
   - Restores your system to original state
   - Removes all optimizations safely

## 🎮 Installation & Usage

### **Quick Start (Recommended)**
```
1. Run as Administrator: RUN_ME_FIRST.bat
2. Follow on-screen prompts
3. Script will handle everything automatically
4. Restart your PC when done
5. Launch your game and enjoy higher FPS!
```

### **Manual Installation** (Advanced Users)
```
Run individual scripts in this order:
1. 1_SYSTEM_OPTIMIZER.bat
2. 2_GRAPHICS_OPTIMIZER.bat
3. 3_POWER_PLAN_OPTIMIZER.bat
4. 4_NETWORK_OPTIMIZER.bat
5. 5_STORAGE_MEMORY_OPTIMIZER.bat
6. 6_CPU_OPTIMIZER.bat
7. 7_ADVANCED_TWEAKS.bat
8. 8_GPU_MEMORY_OPTIMIZER.bat
9. 9_FINAL_CLEANUP.bat
```

## ⚠️ Important Notes

- **RUN AS ADMINISTRATOR** - All scripts require admin privileges
- **RESTART RECOMMENDED** - Restart PC after running for full effect
- **BACKUP FIRST** - We create restore points, but have a backup just in case
- **TEST GRADUALLY** - Run one script, test, then continue if happy
- **MONITOR PERFORMANCE** - Use HWiNFO64 to monitor temps/usage

## 🎯 Manual Game Settings for CoD

After running optimization suite, apply these in-game settings:
- Display Mode: Fullscreen
- Resolution: Matches monitor refresh rate
- Hz: Max your monitor supports
- Graphics Quality: Very Low / Low
- Texture Resolution: Medium
- Texture Filter: Anisotropic (2x)
- View Distance: Short
- Foliage Details: Off
- Shader Quality: Low
- Motion Blur: Off
- Ray Tracing: Off
- NVIDIA DLSS / AMD FSR: OFF (use more resources on iGPU)
- V-Sync: Off
- FPS Cap: 100+ or unlimited

## 🔧 Troubleshooting

### If you get worse performance:
1. Run `ROLLBACK.bat` to restore system
2. Try running individual scripts instead of all at once
3. Check if drivers are up to date

### If games won't launch:
1. Run `ROLLBACK.bat`
2. Manually restore the last system restore point via Windows Recovery

### If you experience stuttering:
- Background apps are running - close them
- GPU drivers might be outdated - update them
- Run `7_ADVANCED_TWEAKS.bat` again

## 📈 Performance Monitoring

Download **HWiNFO64** (Free) to monitor:
- GPU Temperature (should stay under 85°C)
- CPU Temperature (should stay under 80°C)
- GPU Load (should be near 100% in games)
- Memory Usage
- Thermal Throttling

## 🎓 What Each Optimization Does

### System Optimizer
- Disables Aero theme animations
- Disables Windows Search
- Disables SuperFetch
- Disables Cortana
- Disables Telemetry
- Clears temporary files

### Graphics Optimizer
- Enables High Performance GPU mode
- Disables Vsync at GPU level
- Optimizes DirectX 11/12
- Enables GPU scheduling (Windows 11)
- Disables HDR
- Sets game to use dedicated GPU (if available)

### Power Plan
- Creates Ultimate Gaming power plan
- Sets CPU to 100% performance
- Enables turbo boost
- Maximizes GPU clock
- Disables all power savings

### Network Optimizer
- Increases network buffer
- Reduces latency
- Disables QoS
- Optimizes TCP settings

### Storage & Memory
- Clears temp files
- Optimizes virtual memory for gaming
- Clears system cache
- Disables hibernation

### CPU Optimizer
- Forces all cores to max frequency
- Disables C-States
- Optimizes thread scheduling
- Disables SMT load balancing

### Advanced Tweaks
- Clears DirectX shader cache
- Optimizes DLL loading
- Reduces audio latency
- Disables driver telemetry

### GPU Memory Boost
- Increases shared VRAM to maximum
- Optimizes memory access patterns
- Reduces memory bandwidth overhead

## 💡 Tips for Even More FPS

1. **Update GPU Drivers** - Manufacturers release gaming optimizations
2. **Close Background Apps** - Discord, Chrome, etc. use GPU
3. **Lower Streaming/Recording** - OBS uses significant GPU
4. **Disable RGB Lighting** - Some software uses CPU
5. **Use External Cooling** - Undervolt CPU/GPU (Advanced)
6. **Increase Shared VRAM** - BIOS setting (Advanced)

## 🎯 Realistic FPS Expectations

**For Intel iGPU (HD 5500 - Iris Xe):**
- Call of Duty at Very Low: 45-65 FPS after optimization
- Fortnite at Low: 50-60 FPS
- Valorant: 100+ FPS
- CS:GO: 120+ FPS

**For AMD Radeon (Vega - RDNA):**
- Call of Duty at Very Low: 50-70 FPS after optimization
- Fortnite at Low: 60-75 FPS
- Valorant: 100+ FPS
- CS:GO: 150+ FPS

## 📞 Support

If something breaks:
1. Use System Restore (Windows Settings → System → Recovery)
2. Or run `ROLLBACK.bat` to undo all changes

## ⚖️ Disclaimer

This optimization suite modifies Windows settings and registry. While we take precautions:
- Create a system restore point before each operation
- Backup important data before running
- Use at your own risk
- Some changes may affect non-gaming performance

---

**Created for:** Gaming on Low-Mid End Laptops with iGPU  
**Last Updated:** January 2026  
**Version:** 2.0 (Professional Edition)

🎮 **Good luck achieving your 60+ FPS dream!** 🎮
