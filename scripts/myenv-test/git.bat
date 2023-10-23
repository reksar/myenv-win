for /f %%i in ('where git 2^>NUL') do (
  echo [OK][%~n0] Git found.
  exit /b 0
)
echo [ERR][%~n0] Git not found.
exit /b 1
