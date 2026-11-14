@echo off
if not exist "%~dp0AdobeProcessCleaner.exe" (
    echo No se encuentra AdobeProcessCleaner.exe en esta carpeta.
    pause
    exit /b 1
)
"%~dp0AdobeProcessCleaner.exe" %*
exit /b %errorlevel%
