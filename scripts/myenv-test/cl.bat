for /f %%i in ('
  where cl 2^>NUL ^
    ^| findstr /c:"%MYENV_APPS%\\" ^
    ^| findstr /c:"\\VC\Tools\MSVC\\" ^
    ^| findstr /c:"\\cl.exe"
') do (
  echo [OK][%~n0] cl found.
  exit /b 0
)
echo [ERR][%~n0] cl not found.
exit /b 1
