@echo off
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
set ABBYY_State=1
sc query ABBYY.Licensing.FineReader.14.0 |find /i "running" >nul||set ABBYY_State=0
if %ABBYY_State%==0 (
net start ABBYY.Licensing.FineReader.14.0
echo The operation is completed and ABBYY license service is enabled.
pause
) else (
net stop ABBYY.Licensing.FineReader.14.0
echo The operation was completed and ABBYY license service was stopped.
pause
)
