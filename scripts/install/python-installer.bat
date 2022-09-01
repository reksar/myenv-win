@echo off

setlocal
set PY_VERSION=3.10.6
set PY_INSTALLER=python-%PY_VERSION%-amd64.exe
set PY_URL=https://www.python.org/ftp/python/%PY_VERSION%/%PY_INSTALLER%

set destination=%~1

if "%destination%"=="" (
  echo [ERR] Python destination is not specified.
  exit /b 1
)

if exist "%destination%\python.exe" (
  echo [ERR] Already exists: %destination%\python.exe
  exit /b 2
)

echo Installing Python %PY_VERSION% to %destination%

if exist "%destination%\%PY_INSTALLER%" (
  echo [WARN] Python installer already exists.
  goto :INSTALL
)

md "%destination%"

echo|set/p=Downloading Python installer ... 
call download "%PY_URL%" "%destination%\%PY_INSTALLER%"
echo OK

:INSTALL

echo|set/p=Installing ... 

rem  See https://docs.python.org/3.10/using/windows.html#installing-without-ui
"%destination%\%PY_INSTALLER%" /passive ^
  TargetDir="%destination%" ^
  AssociateFiles=0 ^
  Shortcuts=0 ^
  Include_launcher=0 ^
  InstallLauncherAllUsers=0

if %ERRORLEVEL% EQU 0 (echo OK) else (echo ERR)

endlocal
