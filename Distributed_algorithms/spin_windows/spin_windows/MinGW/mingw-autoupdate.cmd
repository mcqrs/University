@echo off
REM Copyright (©) 2011 sar3th
set PATH=%~dp0bin;%PATH%
title MinGW Portable auto-updater
cd /d "%~dp0"
title MinGW Portable auto-updater - fetching updated package list
mingw-get update
title MinGW Portable auto-updater - updating mingw-get
mingw-get install mingw-get
title MinGW Portable auto-updater - fetching updated package list again
mingw-get update
title MinGW Portable auto-updater - updating gcc
mingw-get install gcc
title MinGW Portable auto-updater - updating g++
mingw-get install g++
title MinGW Portable auto-updater - updating mingw32-make
mingw-get install mingw32-make
title MinGW Portable auto-updater - updating gdb
mingw-get install gdb
title MinGW Portable auto-updater - finished updating
pause
cls
exit