@echo off

if "%MYHOME%"=="" (
  echo|set/p=[ERR] MYHOME is not set.
  echo  Can't to determine destination for Python installation.
  exit /b 1
)

if not exist "%MYHOME%" (
  echo [WARN] MYHOME is not exists.
)

rem  According to the dir tree described in `myenv.bat`.
set DESTINATION=%MYHOME%\app\run\python

call %~dp0python-nuget "%DESTINATION%"
