where sed >NUL 2>&1 && (

  echo [OK][%~n0] sed found.

  where sed | findstr /c:"%PWE_APPS%" >NUL 2>&1 || (
    echo [WARN][%~n0] sed is outside the "%PWE_APPS%".
  )

  where sed | findstr /c:"\\sed.exe" >NUL 2>&1 || (
    echo [WARN][%~n0] sed is not ".exe".
  )

  exit /b 0
)

echo [ERR][%~n0] sed not found.
exit /b 1
