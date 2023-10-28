setlocal EnableDelayedExpansion
set UTILS=cat sed
for %%i in (%UTILS%) do (
  where %%i >NUL 2>&1 ^
    && echo [OK][%~n0] %%i found. ^
    || echo [ERR][%~n0] %%i not found.
)
endlocal
