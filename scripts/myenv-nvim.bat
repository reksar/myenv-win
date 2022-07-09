@echo off

set PATH=%MYHOME%\app\run\nvim\bin;%PATH%

where nvim >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
  echo [nvim] ERR: Not found!
)
