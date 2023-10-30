where unzip >NUL 2>&1 && (

  echo [OK][%~n0] unzip found.

  where unzip | findstr /c:"%PWE_APPS%" >NUL 2>&1 || (
    echo [WARN][%~n0] unzip is outside the "%PWE_APPS%".
  )

  where unzip | findstr /c:"\\unzip.exe" >NUL 2>&1 || (
    echo [WARN][%~n0] unzip is not ".exe".
  )

  exit /b 0
)

echo [ERR][%~n0] unzip not found.
exit /b 1
