@echo off

rem  Cygwin is not portable by default. It uses Windows registry.

setlocal
set cygwin_root=%~dp0
set reg_path=HKEY_LOCAL_MACHINE\SOFTWARE\Cygwin\setup

rem  Portability hack. Rewrite the `rootdir` reg key with the actual value.
for /f "delims=" %%i in ('
  reg query %reg_path% /v rootdir 2^>NUL ^| findstr "\<rootdir.*REG_SZ\>"
') do (
  reg add %reg_path% /v rootdir /d "%cygwin_root%\" /f >NUL
)
endlocal
