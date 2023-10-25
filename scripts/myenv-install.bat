@echo off
setlocal
set APPS=python pip vs
set app=%~1
if "%app%" == "" (
  echo [ERR][%~n0] App is not specified!
  echo [INFO][%~n0] Available apps: %APPS%
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
echo [OK][%~n0] The "%app%" app has been installed!
echo [INFO][%~n0] You probably need to restart MyENV.
endlocal
