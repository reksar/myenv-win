@echo off

rem  --------------------------------------------------------------------------
rem  Install to %DESTINATION%:
rem    nuget-python [DESTINATION]
rem    nuget-python [VERSION] [DESTINATION]
rem
rem  https://docs.python.org/3/using/windows.html?highlight=embeddable#windows-nuget
rem  --------------------------------------------------------------------------

setlocal
set batch_path=%~dp0
set utils_path=%batch_path%\..
set PATH=%PATH%;%utils_path%
set NUGET_URL=https://aka.ms/nugetclidl

set /a argc=0
for %%i in (%*) do (
  set /a argc+=1
)

if %argc% EQU 0 (
  echo Destination path is not set.
  exit /b 1
)

if %argc% EQU 1 (
  set destination=%~1
) else (
  set version=-Version %~1
  set destination=%~2
)

if not exist "%destination%" (
  mkdir "%destination%"
)

set nuget=%destination%\nuget.exe
call download %NUGET_URL% "%nuget%"
"%nuget%" install python %version% ^
  -ExcludeVersion -OutputDirectory "%destination%"
del "%nuget%"

robocopy "%destination%\python\tools" "%destination%" *.* ^
  /E /XD "%destination%" /move
rmdir /S /Q "%destination%\python"

endlocal
