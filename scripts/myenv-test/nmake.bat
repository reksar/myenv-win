for /f %%i in ('
  where nmake 2^>NUL ^
    ^| findstr /c:"%MYHOME%\\" ^
    ^| findstr /c:"\\VC\Tools\MSVC\\" ^
    ^| findstr /c:"\\nmake.exe"
') do (
  echo [OK] nmake found.
  goto :EOF
)
echo [ERR] nmake not found.
