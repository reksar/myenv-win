@echo off

setlocal

set PYTHON_PATH=%PWE_APPS%\python

for %%i in (%~dp0..) do set test=%%~fi\pwe-test
call "%test%\pip" && goto :EOF
call "%test%\python" || exit /b %ERRORLEVEL%


rem  --- Check ensurepip ------------------------------------------------------
for /f %%i in ('
  python -m ensurepip --version 2^>NUL ^^
  ^| findstr "pip [0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"
') do (
  goto :ENSUREPIP
)


rem  --- Check pip package exists ---------------------------------------------
if exist "%PYTHON_PATH%\Scripts\pip.exe" (
  echo [WARN] pip.exe found.
) else (
  goto :GET_PIP
)
set SITE_PACKAGES=%PYTHON_PATH%\Lib\site-packages
if exist "%SITE_PACKAGES%\pip" (
  echo [WARN] pip package found. Trying to set sys.path for embedded Python.
  goto :EMBEDDED_PYTHON_PATH
)


:GET_PIP
set GET_PIP_URL=https://bootstrap.pypa.io/get-pip.py
set get_pip=%PYTHON_PATH%get-pip.py
call download %GET_PIP_URL% "%get_pip%" || goto :EOF
python "%get_pip%" || goto :EOF
del "%get_pip%"


:EMBEDDED_PYTHON_PATH
set BOOL=import sys; print(r'%SITE_PACKAGES%' in sys.path)
for /f "delims=" %%i in ('python -c "%BOOL%"') do (
  if "%%i"=="True" (
    echo [WARN] sys.path is already set.
    goto :EOF
  )
)
for /f %%i in ('where %PYTHON_PATH%:python*._pth') do (
  echo %SITE_PACKAGES%>>"%%i"
)


:ENSUREPIP
echo Installing pip using ensurepip module.
python -m ensurepip --root %PYTHON_PATH%
python -m pip install --force-reinstall --upgrade pip


endlocal
