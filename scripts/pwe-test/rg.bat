for /f %%i in ('rg --version 2^>NUL ^| rg "ripgrep \d+.\d+.\d+"') do (
  echo [OK][%~n0] rg found.
  exit /b 0
)
echo [ERR][%~n0] rg not found.
exit /b 1
