@echo off
setlocal
call "%~dp0portable"
"%~dp0nvim.exe" %*
endlocal
