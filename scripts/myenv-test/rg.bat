for /f %%i in ('rg --version ^| rg "ripgrep \d+.\d+.\d+"') do (
  echo [OK] rg found.
  goto :EOF
)
echo [ERR] rg not found.
