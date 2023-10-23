@echo off

setlocal

for %%i in (%~dp0..) do set "scripts=%%~fi"
call "%scripts%\myenv-test\python"
set /a rc=%ERRORLEVEL%

if %rc% EQU 0 (
  echo [ERR][%~n0] Delete the "%MYENV_APPS%\python" first!
  exit /b 1
)

if %rc% LSS 3 (
  echo [WARN][%~n0] Python already exists, but priority will be lower!
)

call "%~dp0python-nuget" "%MYENV_APPS%\python" && exit /b 0

echo [ERR][%~n0] Unable to install Python!
exit /b 2

endlocal
