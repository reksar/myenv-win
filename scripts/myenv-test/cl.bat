for /f %%i in ('
  where cl 2^>NUL ^
    ^| findstr /c:"%MYHOME%\\" ^
    ^| findstr /c:"\\VC\Tools\MSVC\\" ^
    ^| findstr /c:"\\cl.exe"
') do (
  echo [OK] cl found.
  goto :EOF
)
echo [ERR] cl not found.
