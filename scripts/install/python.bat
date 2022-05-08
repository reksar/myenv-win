@echo off

setlocal

set PYTHON_URL=https://www.python.org/ftp/python/3.10.4/python-3.10.4-embed-amd64.zip
set GET_PIP_URL=https://bootstrap.pypa.io/get-pip.py

rem  The `PYTHON` must be set on init.
for /f %%i in ("%PYTHON%") do (
  set PYTHON_PATH=%%~dpi
)

if exist %PYTHON_PATH% (
  echo Already exists: %PYTHON_PATH%
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


rem --- Install pip ----------------------------------------------------------

set get_pip=%PYTHON_PATH%get-pip.py

call download %GET_PIP_URL% "%get_pip%" || goto :EOF

%PYTHON% "%get_pip%" || goto :EOF

del "%get_pip%"


endlocal
