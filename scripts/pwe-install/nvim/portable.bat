@echo off

for %%i in (%~dp0..) do set nvim_path=%%~fi
set XDG_CONFIG_HOME=%nvim_path%\share
set XDG_DATA_HOME=%XDG_CONFIG_HOME%
set XDG_STATE_HOME=%XDG_CONFIG_HOME%

echo [NOTE] Override the path "%LOCALAPPDATA%\nvim" to "%XDG_CONFIG_HOME%".
