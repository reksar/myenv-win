@echo off

setlocal

set PYTHON_URL=https://www.python.org/ftp/python/3.10.4/python-3.10.4-embed-amd64.zip

rem  The `PYTHON` must be set on init.
for /f %%i in ("%PYTHON%") do (
  set PYTHON_PATH=%%~dpi
)

if exist %PYTHON_PATH% (
  echo Already exists: %PYTHON_PATH%
  goto :END
)


rem --- Install Python -------------------------------------------------------

mkdir "%PYTHON_PATH%"

for /f %%i in ("%PYTHON_URL%") do (
  set python_zip=%PYTHON_PATH%\%%~ni%%~xi
)

call download %PYTHON_URL% "%python_zip%" || goto :END
call unzip "%python_zip%" "%PYTHON_PATH%" || goto :END
del "%python_zip%"


call install pip


:END
endlocal
