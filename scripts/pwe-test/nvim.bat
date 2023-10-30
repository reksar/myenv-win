for /f %%i in ('
  where nvim 2^>NUL ^
    ^| findstr /c:"%PWE_APPS%\\" ^
    ^| findstr /c:"\\nvim.exe"
') do (
  echo [OK][%~n0] nvim found.
  exit /b 0
)
echo [ERR][%~n0] nvim not found.
exit /b 1
