@echo off

rem  --------------------------------------------------------------------------
rem  Portable myenv dir three:
rem
rem  MYHOME  <-- portable root
rem  |- app
rem     |- cfg
rem     |  |- myenv
rem     |     |- windows
rem     |        |- scripts  <-- current
rem     |           |- install
rem     |- run  <-- portable software
rem        |- cmake
rem        |- git
rem        |- nvim
rem        |- python
rem        |- vim
rem  --------------------------------------------------------------------------

for %%i in ("%~dp0..\..\..\..\..") do (set MYHOME=%%~fi)


rem  --- Set PATH to Windows utility scripts ----------------------------------

set PATH=%~dp0;%PATH%

rem  Consider the trailing backslash!
set MYENV_SCRIPTS=%MYHOME%\app\cfg\myenv\windows\scripts\

rem  Validate.
if not "%MYENV_SCRIPTS%"=="%~dp0" (
  echo [WARN][MYENV][MYENV_SCRIPTS] "%MYENV_SCRIPTS%" != "%~dp0"
)

set MYENV_SCRIPTS=


rem  --- Set PATH to portable software ----------------------------------------

set MYENV_RUN=%MYHOME%\app\run


rem  --- Git ---
if exist "%MYENV_RUN%\git\bin\git.exe" (
  set PATH=%MYENV_RUN%\git\bin;%PATH%
)


rem  --- Neovim ---
if exist "%MYENV_RUN%\nvim\bin\nvim.exe" (
  set PATH=%MYENV_RUN%\nvim\bin;%PATH%
)


rem  --- Vim ---

for /d %%i in ("%MYENV_RUN%\vim\vim*") do (set MYENV_VIMRUNTIME=%%i)

if not "%MYENV_VIMRUNTIME%"=="" (
  if exist "%MYENV_VIMRUNTIME%\gvim.exe" (
    set PATH=%MYENV_VIMRUNTIME%;%PATH%
  )
)

set MYENV_VIMRUNTIME=


rem  --- Python ---
rem  TODO


set MYENV_RUN=


if "%~1"=="" (cd %MYHOME%) else (cd %1)
