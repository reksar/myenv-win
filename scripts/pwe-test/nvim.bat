where nvim ^
  | findstr /c:"%PWE_APPS%\\nvim" ^
  | findstr /c:"\\nvim.exe" ^
  >NUL || (
    echo [ERR][%~n0] nvim not found.
    exit /b 1
  )
echo [OK][%~n0] nvim found.

rem  Nvim is not portable by default. To run in portable mode,
rem  use `vi` or `gvi`.

where vi ^
  | findstr /c:"%PWE_APPS%\\nvim" ^
  | findstr /c:"\\vi.bat" ^
  >NUL || (
    echo [ERR][%~n0] vi ^(portable nvim^) not found.
    exit /b 2
  )
echo [OK][%~n0] vi ^(portable nvim^) found.

rem  NOTE: Redirect stdpath from stderr to stdout!
vi --headless +"echo stdpath('data')" +q 2>&1 ^
  | findstr /c:"%PWE_APPS%\\nvim\\share\\nvim-data" ^
  >NUL || (
    echo [ERR][%~n0] vi portability is broken!
    exit /b 3
  )

exit /b 0
