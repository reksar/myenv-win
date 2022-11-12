setlocal EnableDelayedExpansion

set utils=cat sed

for %%i in (%utils%) do (

  set found=

  for /f %%j in ('where %%i 2^>NUL') do (
    set found=yes
  )

  if "!found!"=="yes" (
    echo [OK] %%i found.
  ) else (
    echo [ERR] %%i not found.
  )
)

endlocal
