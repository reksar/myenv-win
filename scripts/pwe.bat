@echo off

rem  The path to portable applications. No trailing backslash.
set "PWE_APPS="

if "%PWE_APPS%" == "" (
  echo [ERR][%~nx0] `PWE_APPS` is not set!
  goto :APPS_END
) else (
  if not exist "%PWE_APPS%" (
    echo [ERR][%~n0] "%PWE_APPS%" does not exist!
    goto :APPS_END
  )
)

rem  --- Set %PATH% for portale apps -------------------------------------- {{{

rem  * Git
git --version >NUL 2>&1 && goto :GIT_UTILS
if exist "%PWE_APPS%\git\cmd\git.exe" (
  set "PATH=%PWE_APPS%\git\cmd;%PATH%"
  goto :GIT_UTILS
) else (
  if exist "%PWE_APPS%\git\bin\git.exe" (
    set "PATH=%PWE_APPS%\git\bin;%PATH%"
    goto :GIT_UTILS
  )
)
goto :GIT_END
:GIT_UTILS
for /f %%i in ('where git') do (
  for %%j in (%%~dpi..) do (
    if exist "%%~fj\usr\bin" (
      set "PATH=%%~fj\usr\bin;%PATH%"
      call "%~dp0pwe\git-config"
      goto :GIT_END
    )
  )
)
:GIT_END

rem  * Python
if exist "%PWE_APPS%\python\python.exe" (
  set "PATH=%PWE_APPS%\python;%PWE_APPS%\python\Scripts;%PATH%"
)

rem  * Vim
for /d %%i in ("%PWE_APPS%\vim\vim*") do (
  if exist "%%i\gvim.exe" (
    set "PATH=%%i;%PATH%"
  ) else (
    if exist "%%i\vim.exe" (
      set "PATH=%%i;%PATH%"
    )
  )
)

rem  * Nvim
if exist "%PWE_APPS%\nvim\bin\nvim.exe" (
  set "PATH=%PWE_APPS%\nvim\bin;%PATH%"
)

rem  * Visual Studio
if exist "%PWE_APPS%\vs\vcvars-x64-x64.bat" (
  call "%PWE_APPS%\vs\vcvars-x64-x64.bat"
)

rem  * CMake
if exist "%PWE_APPS%\cmake\bin\cmake.exe" (
  set "PATH=%PWE_APPS%\cmake\bin;%PATH%"
)

rem  * Ripgrep
if exist "%PWE_APPS%\ripgrep\rg.exe" (
  set "PATH=%PWE_APPS%\ripgrep;%PATH%"
)

:APPS_END
rem  ---------------------------------------------------------------------- }}}

set "PATH=%PATH%;%~dp0"

if not "" == "%*" cd /d "%*"
