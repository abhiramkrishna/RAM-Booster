# Universal RAM Booster & System Optimizer

![Platform](https://img.shields.io/badge/Platform-Windows-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A lightweight batch script for Windows 10/11 designed to reduce memory usage, clear system caches, and terminate unnecessary background processes. It works on any manufacturer (ASUS, Dell, HP, Lenovo, etc.) without requiring installation.

## Features

### Memory Optimization
- **Working Set Trim:** Forces active processes to release unused memory using PowerShell (`MinWorkingSet`).
- **Registry Tweaks:** Adjusts `AlwaysUnloadDll` and `LargeSystemCache` to prioritize active applications.
- **Clipboard Flush:** Clears stored clipboard data.

### System Cleanup
- **Cache Removal:** Deletes temporary files, DNS cache, and thumbnail/icon databases to fix UI glitches.
- **Process Killer:** Terminates common background resource hogs (OneDrive, Teams, Cortana, Browser instances) to free up resources for gaming or heavy tasks.
- **Service Management:** Disables non-essential services like SysMain and DiagTrack (Telemetry).

### Boot Configuration
- **Fast Boot:** Checks and enables the "Fast Startup" registry key.
- **Startup Cleanup:** Removes shortcuts from the current user's Startup folder.

## Usage

1.  Download `RAMBooster.bat`.
2.  Right-click the file and select **Run as Administrator**.
3.  Wait for the process to complete (screen may flicker briefly as Explorer restarts).

> **Note:** This script forcefully closes web browsers and background applications. Save your work before running.

## Under the Hood

The core memory reduction relies on the following PowerShell command, which trims the working set of all running processes:

```powershell
$p = Get-Process; foreach($i in $p){try{$i.MinWorkingSet = [System.IntPtr]::Zero}catch{}}
