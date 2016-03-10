@echo off
::
:: auto run multiple applications at the same time
::

set cfgfile=app.cfg

if exist %cfgfile% (
    for /f "eol=; delims= tokens=1" %%i in (%cfgfile%) do (
        call :open %%~ni "%%i"
	call :waitfor 3
	rem dirname %%~dpi
    )
    goto:done
)

goto:usage


:: ------------------------------------
:: sleep
:: ------------------------------------
:waitfor
echo. Waiting for %1 seconds...
setlocal
set /a "t = %1 + 1"
>nul ping 127.0.0.1 -n %t%
endlocal
exit /B 0

:: ------------------------------------
:: public function for start application
:: ------------------------------------
:open
echo.
echo. Starting %~1 ...
if not exist "%~2" (
    echo. "%~2" not found
    goto:eof
)

start/min  "" "%~2"

if %errorlevel% == 0 (
    echo. Starting %~1 SUCCESS
) else (
    echo. Starting %~1 FAIL
)
echo.
goto:eof


:: ------------------------------------
:: complete
:: ------------------------------------
:done
echo. Finished.
exit /B 0

:: ------------------------------------
:: usage
:: ------------------------------------
:usage
echo.
echo. In the current directory to create '%cfgfile%' file
echo. example:
echo. D:\ProgramFiles\aa.exe
echo. E:\ProgramFiles\bb.exe
echo.
goto:eof
