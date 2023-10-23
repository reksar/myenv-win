for /f %%i in ('where cmake 2^>NUL') do (
  for /f "delims=" %%j in ('
    cmake --version ^| findstr "[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"
  ') do (
    echo [OK][%~n0] CMake found.
    exit /b 0
  )
)
echo [ERR][%~n0] CMake not found.
exit /b 1
