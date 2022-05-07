@echo off

setlocal

set url=%1
set file=%~2

powershell -command ^
  "Invoke-WebRequest -UseBasicParsing -Uri '%url%' -OutFile '%file%'"

endlocal
