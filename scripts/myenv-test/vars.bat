@echo off

if "%MYHOME%"=="" (
  echo [ERR] MYHOME is not set.
  exit /b 1
)
if not exist "%MYHOME%" (
  echo [ERR] MYHOME is not exists.
  exit /b 2
)
echo [OK] MYHOME exists.

if "%MYENV%"=="" (
  echo [ERR] MYHOME is not set.
  exit /b 3
)
if not exist "%MYENV%" (
  echo [ERR] MYENV is not exists.
  exit /b 4
)
echo [OK] MYENV exists.

rem  Consider the trailing backslash!
if /i not "%~dp0"=="%MYENV%\windows\scripts\myenv-test\" (
  echo [WARN] MYENV is inconsistent with current test script path.
)
