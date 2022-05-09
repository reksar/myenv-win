@echo off

rem  The `MYHOME` dir can be anywhere, e.g. on an external drive, but it must
rem  contain specific dir sctructure (see the checks below). So we determine it
rem  corresponding to that structure as the abs path relative to the current
rem  file.
for /f %%i in ("%~dp0..\..\..") do (
  rem  ends with \
  set MYHOME=%%~dpi
)


rem --- Check the %MYHOME%[subdirs] -----------------------------------------

setlocal

set CONFIG_DIR=%MYHOME%config
set MYCONF_DIR=%CONFIG_DIR%\myconf
set APP_DIR=%MYHOME%app
set RUN_DIR=%APP_DIR%\run

set /a err=0

for %%i in (%CONFIG_DIR%,%MYCONF_DIR%,%APP_DIR%,%RUN_DIR%) do (
  if not exist %%i (
    echo [MYHOME] Not found: %%i
    set /a err=1
    goto :END
  )
)

:END
rem  The `endlocal` will be implicitly called on exit.
rem  The `if ... (exit ...)` brokes the `call init || [do on init err]`.
exit /b %err%
