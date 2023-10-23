for /f %%i in ('
  pip --version 2^>NUL^|findstr "pip [0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"
') do (
  echo [OK][%~n0] PIP found.
  exit /b 0
)
echo [ERR][%~n0] PIP not found.
exit /b 1
