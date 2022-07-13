@echo off

rem --- Add %CURRENT_DIR% to %PATH% ------------------------------------------

rem  Relative to %MYHOME%
set CURRENT_PATH_SUFFIX=app\cfg\myenv\windows\scripts

rem  Abspath %MYHOME%\%CURRENT_PATH_SUFFIX%\
set CURRENT_DIR=%~dp0

rem  Remove last \
set CURRENT_DIR=%CURRENT_DIR:~0,-1%

set PATH=%PATH%;%CURRENT_DIR%


rem --- Set %MYHOME% ---------------------------------------------------------

rem  %MYHOME% dir can be anywhere, e.g. on an external disk drive, but it must
rem  contain the specific dir structure and be parent of the %CURRENT_DIR%
rem  (see above).
for /f %%i in ("%CURRENT_DIR%\..\..\..\..") do (
  rem  ends with \
  set MYHOME=%%~dpi
)

rem  Remove last \
set MYHOME=%MYHOME:~0,-1%


rem --- Check %MYHOME% -------------------------------------------------------

set /a err=0

if not "%MYHOME%\%CURRENT_PATH_SUFFIX%"=="%CURRENT_DIR%" (
  echo [MYHOME] ERR: %MYHOME% does not contain %CURRENT_PATH_SUFFIX%
  set /a err=1
  goto :END
)


:END
set CURRENT_PATH_SUFFIX=
set CURRENT_DIR=

rem  Avoid `if ... (exit ...)` which does not return %err% and brokes the
rem  `call init || [do something if err]`.
exit /b %err%
