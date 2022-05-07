@echo off

setlocal

set PATH=%PATH%;%PORTABLE_HOME%config\myconf\windows\scripts

set PYTHON_URL=https://www.python.org/ftp/python/3.10.4/python-3.10.4-embed-amd64.zip
set GET_PIP_URL=https://bootstrap.pypa.io/get-pip.py

rem  Assume that this path exists and was checked on init.
set INSTALL_PATH=%PORTABLE_HOME%app\run

set PYTHON_PATH=%INSTALL_PATH%\python

if exist %PYTHON_PATH% (
  echo Dir already exists: %PYTHON_PATH%
  goto :EOF
)


rem --- Sentinel -------------------------------------------------------------

echo.
echo Install %PYTHON_URL%
echo To %PYTHON_PATH%
set /p proceed=Enter 'yes' to proceed: 

if not "%proceed%"=="yes" (
  echo Cancel
  goto :EOF
)


rem --- Install Python -------------------------------------------------------

mkdir "%PYTHON_PATH%"

for /f %%i in ("%PYTHON_URL%") do (
  set python_zip=%PYTHON_PATH%\%%~ni%%~xi
)

call download %PYTHON_URL% "%python_zip%" || goto :EOF
call unzip "%python_zip%" "%PYTHON_PATH%" || goto :EOF
del "%python_zip%"

endlocal
