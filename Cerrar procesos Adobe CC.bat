@echo off
echo ===================================================
echo     Cerrando procesos de Adobe en segundo plano...
echo ===================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$procs=@('Creative Cloud', 'Adobe Desktop Service', 'Creative Cloud Helper', 'Creative Cloud UI Helper', 'CCXProcess', 'CCLibrary', 'CoreSync', 'AdobeIPCBroker', 'CEPHtmlEngine', 'AdobeUpdateService', 'Adobe Installer', 'AdobeARM', 'AcroRd32', 'acrotray', 'AcrobatNotificationClient', 'AdobeCollabSync', 'AdobeNotificationClient', 'AGSService', 'AGMService', 'AdobeGCClient', 'LogTransport2', 'AdobeExtensionsService', 'Adobe Crash Processor', 'armsvc', 'AGCInvokerUtility', 'agshelper', 'Adobe CEF Helper', 'Adobe Spaces Helper'); $count=0; foreach($p in $procs){ $encontrado = Get-Process -Name $p -ErrorAction SilentlyContinue; if($encontrado){ Stop-Process -InputObject $encontrado -Force; Write-Host ('[X] Proceso cerrado: ' + $p); $count++ } }; Write-Host ''; Write-Host ('Limpieza completada. Total de procesos de Adobe cerrados: ' + $count)"

echo.
echo Presiona cualquier tecla para cerrar esta ventana...
pause >nul