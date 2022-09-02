@call "%~dp0myenv-test\vars" || exit /b %ERRORLEVEL%
@call "%~dp0install\%~1"
