@echo off
setlocal
set test=%~dp0myenv-test
echo Testing myenv ...
call "%test%\vars"
call "%test%\python"
call "%test%\pip"
call "%test%\git"
call "%test%\git-utils"
call "%test%\cl"
call "%test%\cmake"
call "%test%\nmake"
call "%test%\rg"
echo DONE
endlocal
