@echo off

setlocal

set version=%~1

for %%i in (%~dp0..) do set "scripts=%%~fi"
call "%scripts%\pwe-test\python"
set /a rc=%ERRORLEVEL%

if %rc% EQU 0 (
  echo [ERR][%~n0] Delete the "%PWE_APPS%\python" first!
  exit /b 1
)

if %rc% LSS 3 (
  echo [WARN][%~n0] Python already exists, but priority will be lower!
)

call "%~dp0python-nuget" "%PWE_APPS%\python" %version% && exit /b 0

echo [ERR][%~n0] Unable to install Python!
exit /b 2

endlocal
