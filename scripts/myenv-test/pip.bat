for /f %%i in ('
  pip --version 2^>NUL^|findstr "pip [0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"
') do (
  echo [OK] PIP found.
  goto :EOF
)
echo [ERR] PIP not found.
exit /b 1
