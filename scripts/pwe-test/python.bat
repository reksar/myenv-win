@echo off

rem  Return codes:
rem    0 - OK
rem    1-2 - Warnings
rem    3-4 - Errors

setlocal

set python_path=
for /f %%i in ('where python 2^>NUL') do (
  set "python_path=%%i"
  goto :CHECK_PYTHON
)

:CHECK_PYTHON

if "%python_path%" == "" (
  echo [ERR][%~n0] Python not found.
  exit /b 3
)

set /a rc=0
if /i not "%python_path%" == "%PWE_APPS%\python\python.exe" (
  set /a rc+=1
  echo [WARN][%~n0] Python is not in %%PWE_APPS%%!
  echo %python_path%|findstr /e /c:"Microsoft\WindowsApps\python.exe" >NUL && (
    set /a rc+=1
    echo [WARN][%~n0] Python is a Windows App!
  )
)

for /f %%i in ('
  python --version 2^>NUL^|findstr /e "[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"
') do (
  echo [OK][%~n0] Python found.
  exit /b %rc%
)
echo [ERR][%~n0] Python path found, but version check failed!
exit /b 4

endlocal
