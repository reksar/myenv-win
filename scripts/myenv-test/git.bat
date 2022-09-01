for /f %%i in ('where git 2^>NUL') do (
  echo   [OK] Git found.
  goto :EOF
)
echo   [ERR] Git not found.
