@echo off

rem  The path to portable applications. No trailing backslash.
set "MYENV_APPS="

if "%MYENV_APPS%" == "" (
  echo [ERR][%~nx0] `MYENV_APPS` is not set!
  goto :APPS_END
) else (
  if not exist "%MYENV_APPS%" (
    echo [ERR][%~n0] "%MYENV_APPS%" does not exist!
    goto :APPS_END
  )
)

rem  --- Set %PATH% for portale apps -------------------------------------- {{{

rem  * Git
git --version >NUL 2>&1 && goto :GIT_UTILS
if exist "%MYENV_APPS%\git\cmd\git.exe" (
  set "PATH=%MYENV_APPS%\git\cmd;%PATH%"
  goto :GIT_UTILS
) else (
  if exist "%MYENV_APPS%\git\bin\git.exe" (
    set "PATH=%MYENV_APPS%\git\bin;%PATH%"
    goto :GIT_UTILS
  )
)
goto :GIT_END
:GIT_UTILS
for /f %%i in ('where git') do (
  for %%j in (%%~dpi..) do (
    if exist "%%~fj\usr\bin" (
      set "PATH=%%~fj\usr\bin;%PATH%"
      call "%~dp0myenv\git-config"
      goto :GIT_END
    )
  )
)
:GIT_END

rem  * Python
if exist "%MYENV_APPS%\python\python.exe" (
  set "PATH=%MYENV_APPS%\python;%MYENV_APPS%\python\Scripts;%PATH%"
)

rem  * Vim
for /d %%i in ("%MYENV_APPS%\vim\vim*") do (
  if exist "%%i\gvim.exe" (
    set "PATH=%%i;%PATH%"
  ) else (
    if exist "%%i\vim.exe" (
      set "PATH=%%i;%PATH%"
    )
  )
)

rem  * Neovim
if exist "%MYENV_APPS%\nvim\bin\nvim.exe" (
  set "PATH=%MYENV_APPS%\nvim\bin;%PATH%"
)

rem  * Visual Studio
if exist "%MYENV_APPS%\vs\vcvars-x64-x64.bat" (
  call "%MYENV_APPS%\vs\vcvars-x64-x64.bat"
)

rem  * CMake
if exist "%MYENV_APPS%\cmake\bin\cmake.exe" (
  set "PATH=%MYENV_APPS%\cmake\bin;%PATH%"
)

rem  * Ripgrep
if exist "%MYENV_APPS%\ripgrep\rg.exe" (
  set "PATH=%MYENV_APPS%\ripgrep;%PATH%"
)

:APPS_END
rem  ---------------------------------------------------------------------- }}}

rem  Utility batch scripts.
set "PATH=%PATH%;%~dp0"

if not "" == "%*" cd /d "%*"
