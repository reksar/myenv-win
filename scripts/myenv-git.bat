@echo off

set PATH=%MYHOME%\app\run\git\bin;%PATH%

for /f %%i in ('git --version') do (
  if not "%%i"=="git" (
    echo [Git] ERR: Not found!
  )
)
