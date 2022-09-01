@echo off

setlocal

set PYTHON_URL=https://www.python.org/ftp/python/3.10.4/python-3.10.4-embed-amd64.zip


rem --- Check that python already exists -------------------------------------

for /f %%i in ('python --version') do (
  if "%%i"=="pip" (
    echo [Install python] python found!
    goto :END
  )
)

rem  The MYPYTHON_PATH must be set on myenv init.
if exist %MYPYTHON_PATH%\python.exe (
  echo [Install python] WARN: %MYPYTHON_PATH%\python.exe found.
  goto :MYENV
)


rem --- Install Python -------------------------------------------------------

mkdir "%MYPYTHON_PATH%"

for /f %%i in ("%PYTHON_URL%") do (
  set python_zip=%MYPYTHON_PATH%\%%~ni%%~xi
)

call download %PYTHON_URL% "%python_zip%" || goto :END
call unzip "%python_zip%" "%MYPYTHON_PATH%" || goto :END
del "%python_zip%"


:MYENV
call myenv-python


call install pip

rem  Embed Python does not have the "builtin" venv package.
pip install virtualenv || goto :END
rem  This dir can be empty, but is required by the virtualenv.
mkdir %MYPYTHON_PATH%\DLLs


:END
endlocal
