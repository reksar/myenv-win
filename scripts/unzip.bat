@echo off

setlocal

set zip=%~1
set path=%~2
set powershell=%WINDIR%\system32\WindowsPowerShell\v1.0\powershell.exe

%powershell% -command ^
  "Expand-Archive '%zip%' -DestinationPath '%path%'"

endlocal
