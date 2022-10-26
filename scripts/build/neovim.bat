@echo off

rem  NOTE
rem  Neovim can only be built using the Visual Studio >= 2017 CMake generator.

rem  REQUIREMENTS
rem
rem  - VS Build Tools <https://aka.ms/vs/17/release/vs_buildtools.exe>
rem    * MSVC (v143)
rem    * SDK for Windows (10)
rem    See https://docs.microsoft.com/en-us/visualstudio/releases/2022/release-history
rem
rem  - CMake: https://cmake.org/download
rem
rem  - Git: https://git-scm.com/download/win
rem    Needed for some patches in `cmake.deps\CMakeLists.txt`.
rem
rem  USING
rem
rem  Place this script into the Neovim sources root and init the related VS
rem  `vcvars` before running this.


rem  --- Settings -------------------------------------------------------------

rem  Run this script from the Neovim sources root.
set ROOT=%CD%

rem  Can be:
rem  - Release
rem  - RelWithDebInfo
rem  - Debug
set CMAKE_BUILD_TYPE=Release

rem  Can be:
rem  - ON
rem  - OFF
set USE_BUNDLED=ON

rem  Can be:
rem  - NMake Makefiles
rem  - Ninja
rem  - Visual Studio vv yyyy [arch]
set CMAKE_GENERATOR=NMake Makefiles

rem  To build the bundled Neovim.
set DEPS_SRC=%ROOT%\cmake.deps
set DEPS_BUILD_DIR=%ROOT%\.deps
set DEPS_PREFIX=%DEPS_BUILD_DIR%\usr

set BUSTED_OUTPUT_TYPE=nvim
set NVIM_BUILD_DIR=%ROOT%\build


rem  --- Main -----------------------------------------------------------------

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


rem  --------------------------------------------------------------------------
:BUILD
setlocaL

rem  First two args.
set SRC_DIR=%~1
set BUILD_DIR=%~2

rem  Remaining args.
for /f "tokens=2*" %%i in ("%*") do (
  set CMAKE_VARS=%%j
)

mkdir "%BUILD_DIR%"
cd "%BUILD_DIR%"
cmake -G "%CMAKE_GENERATOR%" %CMAKE_VARS% "%SRC_DIR%" || exit /b 1
cmake --build . --config %CMAKE_BUILD_TYPE% || exit /b 2

endlocal
goto :EOF
rem  --------------------------------------------------------------------------


:END
cd %ROOT%
