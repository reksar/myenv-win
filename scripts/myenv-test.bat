@echo off
setlocal
set test=%~dp0myenv-test
echo Testing myenv ...
call "%test%\python"
call "%test%\git"
echo DONE
endlocal
