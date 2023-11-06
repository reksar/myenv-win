@echo off

rem  --------------------------------------------------------------------------
rem  Shows the cycle versions for the specified [app]:
rem
rem    versions [app]
rem
rem  Output a list of lines in the format:
rem
rem    <cycle version>|<latest version in cycle>|<support>
rem  --------------------------------------------------------------------------

setlocal EnableDelayedExpansion

set URL=https://endoflife.date/api

set app=%~1
if "%app%" == "" exit /b 1

call "%~dp0pwe-test\curl" >NUL || exit /b 2

rem  Exit if %app% is unknown.
for /f %%i in ('curl --silent %URL%/all.json') do (
  echo %%i | findstr /rc:"\<%app%\>" >NUL 2>&1 || exit /b 3
)

for /f %%i in ('curl --silent %URL%/%app%.json') do set "versions=%%i"

set /a chunk=0
:LOOP
set /a chunk+=1
for /f "tokens=%chunk% delims=[]{}" %%i in ("%versions%") do (
  call :SHOW_VERSION "%%i"
  goto :LOOP
)
exit /b 0


:SHOW_VERSION
set line=%~1
set cycle=
set latest=
set support=
set /a n_name=1
set /a n_value=2
:PARSE_LINE
for /f "tokens=%n_name%,%n_value% delims=,:" %%i in ("%line%") do (
  if "%%~i" == "cycle" set cycle=%%~j
  if "%%~i" == "latest" set latest=%%~j
  if "%%~i" == "support" set support=%%~j
  set /a n_name+=2
  set /a n_value=!n_name!+1
  goto :PARSE_LINE
)
if not "%cycle%" == "" echo %cycle%^|%latest%^|%support%
exit /b


endlocal
