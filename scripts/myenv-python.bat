@echo off

rem --- Python path ----------------------------------------------------------

set MYPYTHON_PATH=%MYHOME%app\run\python

if not exist %MYPYTHON_PATH% (
  echo [Python] ERR: %MYPYTHON_PATH% is not found.
  echo [Python] Try to `install python`.
  goto :END
)

set PYTHON_SCRIPTS_DIR=%MYPYTHON_PATH%\Scripts

if not exist %PYTHON_SCRIPTS_DIR% (
  echo [Python] ERR: %PYTHON_SCRIPTS_DIR% is not found.
  echo [Python] It must contain the pip at least, so try to `install pip`.
  echo [Python] Or try to `install python`.
  goto :END
)

set SITE_PACKAGES_DIR=%MYPYTHON_PATH%\Lib\site-packages

if not exist %SITE_PACKAGES_DIR% (
  echo [Python] ERR: %SITE_PACKAGES_DIR% is not found.
  echo [Python] It must contain the pip at least, so try to `install pip`.
  echo [Python] Or try to `install python`.
  goto :END
)


set PATH_BACKUP=%PATH%

rem  Substitute the "app\run\python" in the %PATH% by empty str to check if
rem  it already exists.
if "%PATH:app\run\python=%"=="%PATH%" (
  rem  Prepending is important!
  set PATH=%MYPYTHON_PATH%;%PYTHON_SCRIPTS_DIR%;%PATH%
)


rem --- Python test ----------------------------------------------------------

set /a err=1

for /f "tokens=1,2" %%i in ('python --version') do (
  if not "%%i"=="Python" (
    goto :PYTHON_ERR
  )
  set /a err=0
  set PYTHON_VERSION=%%j
)

:PYTHON_ERR
if %err% EQU 1 (
  echo [Python] ERR: running `python --version`
  echo [Python] Try to `install python`.
  goto :END
)

set /a err=0

if not "%PYTHON_VERSION:~0,1%"=="3" (
  echo [Python] WARN: Python version != 3
)


rem --- Pip test -------------------------------------------------------------

set /a err=2

for /f %%i in ('pip --version') do (
  if not "%%i"=="pip" (
    goto :PIP_ERR
  )
  set /a err=0
)

:PIP_ERR
if %err% EQU 2 (
  echo [Python] WARN: running `pip --version`
  echo [Python] Try to `install pip`.
)

set /a err=0


:END

if %err% NEQ 0 (
  set PATH=%PATH_BACKUP%
)

set err=
set PATH_BACKUP=
set PYTHON_SCRIPTS_DIR=
set SITE_PACKAGES_DIR=
set PYTHON_VERSION=
