@echo off

setlocal

for %%i in (%~dp0..\..) do set "git_dir=%%~fi\.git"

rem  NOTE: %git_config% is a disallowed var name in this case!
set git_cfg=git --git-dir="%git_dir%" config --local

%git_cfg% --get filter.clear-base-paths.clean >NUL ^
  || %git_cfg% filter.clear-base-paths.clean scripts/git/clear-base-paths.sh

endlocal
