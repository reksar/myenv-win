@echo off

rem  Init the portable environment.
call "%~dp0myenv-paths" || goto :EOF
call myenv-python
call myenv-git
call myenv-nvim
cd %MYHOME%
