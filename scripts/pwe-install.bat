@echo off

setlocal

set INSTALLERS=%~dp0pwe-install

rem  The first arg is the app name.
set app=%~1

rem  All other args are options.
for /f "tokens=1,* delims= " %%i in ("%*") do set options=%%j

for %%i in (%INSTALLERS%\*.bat) do if "%app%" == "%%~ni" goto :INSTALL

if "%app%" == "" (
  echo [ERR][%~n0] App is not specified!
) else (
  echo [ERR][%~n0] There is no app "%app%"!
)
echo [INFO][%~n0] Available apps:
for %%i in (%INSTALLERS%\*.bat) do echo * %%~ni
exit /b 1

:INSTALL
echo [INFO][%~n0] Installing "%app%".
call "%~dp0pwe-test\vars" || exit /b %ERRORLEVEL%
call "%~dp0pwe-test\curl" || exit /b %ERRORLEVEL%
call "%~dp0pwe-install\%app%" %options% || exit /b %ERRORLEVEL%
echo [OK][%~n0] "%app%" has been installed.
echo [INFO][%~n0] You probably need to restart the PWE.

endlocal
