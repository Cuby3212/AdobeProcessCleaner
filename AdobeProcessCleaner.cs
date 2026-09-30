using System;
using System.Diagnostics;
using System.Reflection;

[assembly: AssemblyTitle("Cierra procesos en segundo plano de Adobe")]
[assembly: AssemblyDescription("Adobe Process Cleaner")]
[assembly: AssemblyCompany("Cuby3212")]
[assembly: AssemblyProduct("Adobe Process Cleaner")]
[assembly: AssemblyCopyright("Open Source - Licencia MIT")]
[assembly: AssemblyFileVersion("1.0.0.0")]

namespace AdobeCleaner {
    class Program {
        static void Main() {
            Console.Title = "Adobe Process Cleaner";
            Console.WriteLine("===================================================");
            Console.WriteLine("    Cerrando procesos de Adobe en segundo plano...");
            Console.WriteLine("===================================================\n");

            string psCommand = "$procs=@('Creative Cloud','Adobe Desktop Service','Creative Cloud Helper','Creative Cloud UI Helper','CCXProcess','CCLibrary','CoreSync','AdobeIPCBroker','CEPHtmlEngine','AdobeUpdateService','Adobe Installer','AdobeARM','AcroRd32','acrotray','AcrobatNotificationClient','AdobeCollabSync','AdobeNotificationClient','AGSService','AGMService','AdobeGCClient','LogTransport2','AdobeExtensionsService','Adobe Crash Processor','armsvc','AGCInvokerUtility','agshelper','Adobe CEF Helper','Adobe Spaces Helper'); $count=0; foreach($p in $procs){ $proc = Get-Process -Name $p -ErrorAction SilentlyContinue; if($proc){ Stop-Process -InputObject $proc -Force; Write-Host ('[X] Proceso cerrado: ' + $p); $count++ } }; Write-Host \"`nTotal de procesos cerrados: $count\"";

            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "powershell.exe";
            psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command \"" + psCommand + "\"";
            psi.UseShellExecute = false;

            Process p = Process.Start(psi);
            p.WaitForExit();

            Console.WriteLine("\nPresiona cualquier tecla para cerrar esta ventana...");
            Console.ReadKey();
        }
    }
}