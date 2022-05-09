@echo off

setlocal

set GET_PIP_URL=https://bootstrap.pypa.io/get-pip.py


rem --- Check that pip already exists ----------------------------------------

for /f %%i in ('pip --version') do (
  if "%%i"=="pip" (
    echo [Install pip] pip found!
    goto :END
  )
)


rem --- Require python -------------------------------------------------------

set /a err=1

for /f %%i in ('python --version') do (
  if not "%%i"=="Python" (
    goto :IS_PYTHON_ERR
  )
  set /a err=0
)

:IS_PYTHON_ERR
if %err% EQU 1 (
  echo [Install pip] ERR: Python not found.
  echo [Install pip] Try to `install python` first.
  goto :END
)

set /a err=0


rem --- Check required PATHs -------------------------------------------------

if "%MYPYTHON_PATH%"=="" (
  echo [Install pip] ERR: MYPYTHON_PATH is not set!
  goto :END
)

setlocal EnableDelayedExpansion

if "!PATH:%MYPYTHON_PATH%=!"=="%PATH%" (
  echo [Install pip] ERR: %MYPYTHON_PATH% not in PATH!
  endlocal
  goto :END
)

if "!PATH:%MYPYTHON_PATH%\Scripts=!"=="%PATH%" (
  echo [Install pip] ERR: %MYPYTHON_PATH%\Scripts not in PATH!
  endlocal
  goto :END
)

endlocal


rem --- Check pip executables -------------------------------------------------

set SITE_PACKAGES=%MYPYTHON_PATH%\Lib\site-packages

if exist "%MYPYTHON_PATH%\Scripts\pip.exe" (
  echo [Install pip] WARN: pip.exe found.
) else (
  goto :INSTALL_PIP
)

if exist "%SITE_PACKAGES%\pip" (
  echo [Install pip] WARN: pip package found, but can't run sorrectly.
  echo [Install pip] Trying to set sys.path for Python.
  goto :PYTHON_SYS_PATH
)


rem --- Install pip ----------------------------------------------------------

:INSTALL_PIP

set get_pip=%MYPYTHON_PATH%get-pip.py

call download %GET_PIP_URL% "%get_pip%" || goto :EOF
python "%get_pip%" || goto :EOF
del "%get_pip%"


rem --- Set Python sys.path --------------------------------------------------

:PYTHON_SYS_PATH

set BOOL=import sys; print(r'%SITE_PACKAGES%' in sys.path)

for /f "delims=" %%i in ('python -c "%BOOL%"') do (
  if "%%i"=="True" (
    echo [Install pip] WARN: sys.path is already set.
    goto :END
  )
)

for /f %%i in ('where %MYPYTHON_PATH%:python*._pth') do (
  echo %SITE_PACKAGES%>>"%%i"
)


:END
endlocal
