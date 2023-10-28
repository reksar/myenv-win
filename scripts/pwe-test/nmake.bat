for /f %%i in ('
  where nmake 2^>NUL ^
    ^| findstr /c:"%PWE_APPS%\\" ^
    ^| findstr /c:"\\VC\Tools\MSVC\\" ^
    ^| findstr /c:"\\nmake.exe"
') do (
  echo [OK][%~n0] nmake found.
  exit /b 0
)
echo [ERR][%~n0] nmake not found.
exit /b 1
