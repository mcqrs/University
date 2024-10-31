@echo off
REM Copyright (©) 2010-2011 sar3th
set PATH=%~dp0bin;%PATH%
title MinGW Portable Command Prompt
cd /d "%~dp0"
cmd /k "echo Welcome to MinGW Portable's Command Prompt! && echo To install new packages or updates, use mingw-get. && echo Run mingw-get --help for more information."
cls
exit