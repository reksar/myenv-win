curl --version >NUL 2>&1 && (
  echo [OK][%~n0] curl found.
  for /f %%i in ('curl --silent https://github.com') do (
    echo [OK][%~n0] curl tested.
    exit /b 0
  )
  echo [ERR][%~n0] Cannot GET https://github.com. 1>&2
  exit /b 1
)
echo [ERR][%~n0] curl not found. 1>&2
exit /b 2
