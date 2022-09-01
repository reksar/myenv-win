@echo off

rem  --------------------------------------------------------------------------
rem  Install Python to %DESTINATION%:
rem    nuget-python [DESTINATION]
rem    nuget-python [VERSION] [DESTINATION]
rem
rem  https://docs.python.org/3/using/windows.html?highlight=embeddable#windows-nuget
rem  --------------------------------------------------------------------------

setlocal
set NUGET_URL=https://aka.ms/nugetclidl

set utils_path=%~dp0..
set PATH=%utils_path%;%PATH%

set /a argc=0
for %%i in (%*) do (
  set /a argc+=1
)

if %argc% EQU 1 (
  set destination=%~1
)

if %argc% GTR 1 (
  set version=-Version %~1
  set destination=%~2
)

if "%destination%"=="" (
  echo [ERR] Python destination is not specified.
  exit /b 1
)

if exist "%destination%" (
  echo [WARN] Already exists: %destination%
) else (
  md "%destination%"
)

set nuget=%destination%\nuget.exe

echo|set/p=Downloading nuget ... 
call download "%NUGET_URL%" "%nuget%"
echo OK

rem  Using `-ExcludeVersion` to use static dir name - `python`.
"%nuget%" install python %version% ^
  -ExcludeVersion -OutputDirectory "%destination%"

del "%nuget%"

echo Moving files to destination ...
robocopy "%destination%\python\tools" "%destination%" *.* ^
  /xd "%destination%" /move /s >NUL

rem  Remove `python` dir created by nuget.
rd /s /q "%destination%\python"

echo DONE
endlocal
