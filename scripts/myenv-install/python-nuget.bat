@echo off

rem  --------------------------------------------------------------------------
rem  Installs Python to %destination%:
rem
rem    python-nuget [destination] {version}
rem
rem  https://docs.python.org/3/using/windows.html?highlight=embeddable#windows-nuget
rem  --------------------------------------------------------------------------

setlocal

set NUGET_URL=https://aka.ms/nugetclidl

set destination=%~1
set version=%~2

if not "%version%" == "" set version=-Version %version%

if "%destination%" == "" (
  echo [ERR][%~n0] Python destination is not specified!
  exit /b 1
)

if exist "%destination%" (
  echo [WARN][%~n0] Destination "%destination%" already exist!
) else (
  md "%destination%"
)

set "nuget=%destination%\nuget.exe"
echo [INFO][%~n0] Downloading nuget
curl --silent --location ^
  --user-agent "Mozilla/4.0 (compatible; Win32; WinHttp.WinHttpRequest.5)" ^
  --output "%nuget%" "%NUGET_URL%" || (
    echo [ERR][%~n0] Unable to get nuget!
    exit /b 2
  )
echo [INFO][%~n0] Getting Python with nuget
rem  `-ExcludeVersion` allows a static `python` dir name.
"%nuget%" install python %version% ^
  -ExcludeVersion -OutputDirectory "%destination%" || (
    echo [ERR][%~n0] Unable to get a Python with nuget!
    exit /b 3
  )
del "%nuget%"

echo [INFO][%~n0] Moving files to destination
robocopy "%destination%\python\tools" "%destination%" *.* ^
  /xd "%destination%" /move /s >NUL
rem  Remove `python` dir created by nuget.
rd /s /q "%destination%\python"

exit /b 0
endlocal
