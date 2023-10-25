@echo off
setlocal
set "test=%~dp0myenv-test"
if "%test%" == "%CD%" cd ..
echo [INFO][%~n0] --- Testing MyENV ---
call "%test%\vars"
call "%test%\curl"
call "%test%\git"
call "%test%\git-utils"
call "%test%\python"
call "%test%\pip"
call "%test%\cl"
call "%test%\nmake"
call "%test%\cmake"
call "%test%\rg"
echo [INFO][%~n0] --- Done ---
endlocal
