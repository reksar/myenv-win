@echo off
setlocal
set APPS=python pip
set app=%~1
if "%app%" == "" (
  echo [ERR][%~n0] App is not specified!
  goto :EOF
)
for %%i in (%APPS%) do (
  if "%%i" == "%app%" (
    if exist "%~dp0myenv-install\%app%.bat" (
      goto :INSTALL
    ) else (
      echo [ERR][%~n0] Installer for the app "%app%" is not found!
      goto :EOF
    )
  )
)
echo [ERR][%~n0] App "%app%" is not available!
echo [INFO][%~n0] Available apps: %APPS%
goto :EOF
:INSTALL
echo [INFO][%~n0] Installing "%app%".
call "%~dp0myenv-test\vars" || exit /b %ERRORLEVEL%
call "%~dp0myenv-test\curl" || exit /b %ERRORLEVEL%
call "%~dp0myenv-install\%app%" || exit /b %ERRORLEVEL%
echo [INFO][%~n0] The "%app%" has been installed!
endlocal
