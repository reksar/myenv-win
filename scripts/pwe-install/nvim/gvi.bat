@echo off
setlocal
call "%~dp0portable"
if not "%~1" == "" set workdir=/d %~1
start %workdir% %~dp0nvim-qt.exe
endlocal
