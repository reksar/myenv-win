@echo off

for %%i in (%~dp0..) do set nvim_path=%%~fi
set XDG_CONFIG_HOME=%nvim_path%\share
set XDG_DATA_HOME=%XDG_CONFIG_HOME%
set XDG_STATE_HOME=%XDG_CONFIG_HOME%

echo [NOTE] Override the path "%LOCALAPPDATA%\nvim" to "%XDG_CONFIG_HOME%".


rem  --- NvChad requirements ---------------------------------------------- {{{
rem  See https://nvchad.com/docs/quickstart/install

gcc --version 2>NUL || (
  echo [WARN] *NvChad* requires *GCC*, which is not found!
  goto :CYGWIN
)
make --version 2>NUL || (
  echo [WARN] *NvChad* requires *make*, which is not found!
  goto :CYGWIN
)
goto :EOF

:CYGWIN
echo [INFO] Adding %%PATH%% to *Cygwin* binaries.
for %%i in ("%~dp0..\..\cygwin\bin") do set "cygwin_bin=%%~fi"
if not exist "%cygwin_bin%\gcc.exe" (
  echo [ERR] Cygwin *GCC* not found!
  goto :EOF
)
if not exist "%cygwin_bin%\make.exe" (
  echo [ERR] Cygwin *make* not found!
  goto :EOF
)
set "PATH=%PATH%;%cygwin_bin%"

rem  }}}
