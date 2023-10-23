setlocal EnableDelayedExpansion

set pythons=
set /a pythons_count=0

for /f %%i in ('where python 2^>NUL') do (
  set /a pythons_count+=1
  set pythons[!pythons_count!]=%%i
)


set /a path_warn=0

for /f %%i in ('
  echo %pythons[1]%^|findstr /e /c:"Microsoft\WindowsApps\python.exe"
') do (
  set /a path_warn+=1
  echo [WARN][%~n0] Python is a Windows App.
)

if /i not "%pythons[1]%" == "%MYENV_APPS%\python\python.exe" (
  set /a path_warn+=1
  echo [WARN][%~n0] Python is not in %%MYENV_APPS%%.
)

if %path_warn% NEQ 0 (
  if %pythons_count% GTR 1 (
    echo [WARN][%~n0] Secondary Pythons found in %%PATH%%.
  )
)


for /f %%i in ('
  python --version 2^>NUL^|findstr /e "[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"
') do (
  echo [OK][%~n0] Python found.
  exit /b 0
)

echo [ERR][%~n0] Python not found.
exit /b 1

endlocal
