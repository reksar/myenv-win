@echo off

rem  Init the portable environment.

call "%~dp0myhome" || goto :EOF

set PATH=%PATH%;%~dp0

call myenv-python
