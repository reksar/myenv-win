@echo off

if "%PWE_APPS%" == "" (
  echo [ERR][%~n0] %%PWE_APPS%% is not set.
  exit /b 1
)
if not exist "%PWE_APPS%" (
  echo [ERR][%~n0] %%PWE_APPS%% does not exist.
  exit /b 2
)
echo [OK][%~n0] %%PWE_APPS%% exist.
exit /b 0
