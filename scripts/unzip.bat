@echo off

setlocal

set zip=%~1
set path=%~2

rem  Requires the powershell v5+
%POWERSHELL% -command ^
  "Expand-Archive '%zip%' -DestinationPath '%path%'"

endlocal
