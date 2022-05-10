@echo off

setlocal

set zip=%~1
set destination=%~2

rem  Requires the powershell v5+
powershell -command ^
  "Expand-Archive '%zip%' -DestinationPath '%destination%'"

endlocal
