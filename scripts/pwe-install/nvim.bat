@echo off
setlocal

set DESTINATION=%PWE_APPS%\nvim
set NAME=nvim-win64
set ZIP_NAME=%NAME%.zip
set URL=https://github.com/neovim/neovim/releases/download/stable/%ZIP_NAME%

set n0=%~n0
set dp0=%~dp0
set force=
:PARSE_ARGS
set current=%~1
if not "%current%" == "" (
  if not "%current:~0,1%" == "-" (
    shift
    goto :PARSE_ARGS
  )
  if "%current%" == "-force" set force=true
  shift
  goto :PARSE_ARGS
)

for %%i in (%dp0%..) do set "scripts=%%~fi"

call "%scripts%\pwe-test\nvim" && (
  if not "%force%" == "true" (
    echo [ERR][%n0%] Delete the "%DESTINATION%" first or add a `-force` arg!
    exit /b 1
  )
)

if exist "%DESTINATION%" (
  echo [WARN][%n0%] Deleting existing "%DESTINATION%".
  rd /s /q "%DESTINATION%"
)
md "%DESTINATION%"

set zip=%DESTINATION%\%ZIP_NAME%

echo [INFO][%n0%] Downloading Nvim ZIP.
curl --silent --location ^
  --user-agent "Mozilla/4.0 (compatible; Win32; WinHttp.WinHttpRequest.5)" ^
  --output "%zip%" "%URL%" || (
    echo [ERR][%n0%] Unable to download Nvim!
    exit /b 2
  )

echo [INFO][%n0%] Extracting Nvim.
call "%scripts%\pwe-test\unzip" && (
  unzip -q "%zip%" -d "%DESTINATION%" || (
    echo [ERR][%n0%] Unable to extract Nvim!
    exit /b 3
  )
) || (
  rem  In Windows 10 build >= 17063 the `tar` is available.
  if exist "%SYSTEMROOT%\System32\tar.exe" (
    echo [WARN][%n0%] Using `tar` for Windows.
    "%SYSTEMROOT%\System32\tar.exe" -xf "%zip%" -C "%DESTINATION%" || (
      echo [ERR][%n0%] Unable to extract Nvim!
      exit /b 3
    )
  ) else (
    echo [ERR][%n0%] No archivers found!
    exit /b 4
  )
)
del "%zip%"

set extracted_path=%DESTINATION%\%NAME%
if not exist "%extracted_path%" (
  echo [ERR][%n0%] Cannot find extracted files!
  exit /b 5
)
echo [INFO][%n0%] Moving files to destination.
robocopy "%extracted_path%" "%DESTINATION%" *.* ^
  /xd "%DESTINATION%" /move /s >NUL
copy /y "%dp%nvim\portable.bat" "%DESTINATION%\bin" >NUL
copy /y "%dp%nvim\vi.bat" "%DESTINATION%\bin" >NUL
copy /y "%dp%nvim\gvi.bat" "%DESTINATION%\bin" >NUL

echo [NOTE][%n0%] Recommended fonts https://www.nerdfonts.com

exit /b 0
endlocal
