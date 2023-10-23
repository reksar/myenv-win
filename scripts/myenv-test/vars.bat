@echo off

if "%MYENV_APPS%" == "" (
  echo [ERR][%~n0] %%MYENV_APPS%% is not set.
  exit /b 1
)
if not exist "%MYENV_APPS%" (
  echo [ERR][%~n0] %%MYENV_APPS%% does not exist.
  exit /b 2
)
echo [OK][%~n0] %%MYENV_APPS%% exist.
