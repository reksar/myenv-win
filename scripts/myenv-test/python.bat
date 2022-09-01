setlocal EnableDelayedExpansion


set paths=
set /a count=0

for /f %%i in ('where python 2^>NUL') do (
  set /a count+=1
  set paths[!count!]=%%i
)


set /a path_warn=0

for /f %%i in ('
  echo %paths[1]%^|findstr /e /c:"Microsoft\WindowsApps\python.exe"
') do (
  set /a path_warn=1
  echo   [WARN] Python is Windows App.
)

if /i not "%paths[1]%"=="%MYHOME%\app\run\python\python.exe" (
  set /a path_warn=1
  echo   [WARN] Python path is not in myenv.
)

if %path_warn% NEQ 0 (
  if %count% GTR 1 (
    echo   [WARN] Secondary Pythons found in PATH.
  )
)


for /f %%i in ('
  python --version^|findstr /e "[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*"
') do (
  echo   [OK] Python found.
  goto :END
)


echo   [ERR] Python not found.

:END
endlocal
