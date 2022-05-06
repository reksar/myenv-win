@echo off

rem  USING
rem
rem  Use "<ARCH> Native Tools Command Prompt for VS". This initializes env vars
rem  for manual use of VS Build Tools in cmd.
rem
rem  Run from the neovim root dir:
rem
rem    `scripts\build-windows.bat`.
rem
rem  REQUIREMENTS
rem
rem  - Native Tools Command Prompt for VS. Minimal installation is:
rem
rem      - VS Build Tools <https://aka.ms/vs/17/release/vs_buildtools.exe>
rem        * MSVC <v143>
rem        * SDK for Windows <10>
rem
rem        See https://docs.microsoft.com/en-us/visualstudio/releases/2022/release-history
rem
rem  - CMake: https://cmake.org/download
rem
rem  - Git: https://git-scm.com/download/win
rem    Needed for some patches in `third-party\CMakeLists.txt`


rem --- Settings -------------------------------------------------------------

rem  Can be:
rem  - Release
rem  - RelWithDebInfo
rem  - Debug
set CMAKE_BUILD_TYPE=Release

rem  Can be:
rem  - ON
rem  - OFF
set USE_BUNDLED=ON

rem  NMake comes with VS Build Tools.
set CMAKE_GENERATOR=NMake Makefiles

set BUSTED_OUTPUT_TYPE=nvim

rem  Run this script from the neovim root dir.
set ROOT=%CD%

set NVIM_BUILD_DIR=%ROOT%\build
set DEPS_SRC=%ROOT%\third-party
set DEPS_BUILD_DIR=%ROOT%\.deps
set DEPS_PREFIX=%DEPS_BUILD_DIR%\usr


rem --- Main -----------------------------------------------------------------

if "%USE_BUNDLED%"=="ON" (
  call :BUILD %DEPS_SRC% %DEPS_BUILD_DIR% ^
    -DCMAKE_BUILD_TYPE=%CMAKE_BUILD_TYPE% ^
    -DUSE_BUNDLED=%USE_BUNDLED% ^
    || goto :END
)

call :BUILD %ROOT% %NVIM_BUILD_DIR% ^
  -DCMAKE_BUILD_TYPE=%CMAKE_BUILD_TYPE% ^
  -DBUSTED_OUTPUT_TYPE=%BUSTED_OUTPUT_TYPE% ^
  -DDEPS_PREFIX=%DEPS_PREFIX% ^
  || goto :END

goto :END


rem --------------------------------------------------------------------------
:BUILD
setlocaL

rem  First 2 args
set SRC_DIR=%~1
set BUILD_DIR=%~2
rem  Remaining args
for /f "tokens=2*" %%i in ("%*") do (
  set CMAKE_VARS=%%j
)

mkdir "%BUILD_DIR%"
cd "%BUILD_DIR%"
cmake -G "%CMAKE_GENERATOR%" %CMAKE_VARS% "%SRC_DIR%" || exit /b 1
cmake --build . --config %CMAKE_BUILD_TYPE% || exit /b 1

endlocal
goto :EOF
rem --------------------------------------------------------------------------


:END
cd %ROOT%
