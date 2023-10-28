@echo off

setlocal

set DESTINATION=%PWE_APPS%\python

set n0=%~n0
set dp0=%~dp0

set version=
set force=

:PARSE_ARGS
set current=%~1
if not "%current%" == "" (
  if not "%current:~0,1%" == "-" (
    shift
    goto :PARSE_ARGS
  )
  if "%current%" == "-version" set version=%~2
  if "%current%" == "-force" set force=true
  shift
  goto :PARSE_ARGS
)

for %%i in (%dp0%..) do set scripts=%%~fi
call "%scripts%\pwe-test\python"
set /a rc=%ERRORLEVEL%

if %rc% EQU 0 (
  if "%force%" == "true" (
    echo [WARN][%n0%] Deleting existing "%DESTINATION%".
    rmdir /s /q "%DESTINATION%"
  ) else (
    echo [ERR][%n0%] Delete the "%DESTINATION%" first or add a `-force` arg!
    exit /b 1
  )
) else (
  if %rc% LSS 3 (
    echo [WARN][%n0%] Non-portable Python found!
  )
)

call "%dp0%python\nuget" "%DESTINATION%" %version% || (
  echo [ERR][%n0%] Unable to install Python!
  exit /b 2
)
call pwe-install pip || exit /b 3

exit /b 0
endlocal
