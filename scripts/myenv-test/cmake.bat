for /f %%i in ('where cmake 2^>NUL') do (
  for /f "delims=" %%j in ('
    cmake --version ^| findstr "[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"
  ') do (
    echo [OK] CMake found.
    goto :CMAKE_END
  )
)
echo [ERR] CMake not found.
:CMAKE_END
