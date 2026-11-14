using System;
using System.ComponentModel;
using System.Diagnostics;
using System.Reflection;

[assembly: AssemblyTitle("Cierra procesos en segundo plano de Adobe")]
[assembly: AssemblyDescription("Adobe Process Cleaner")]
[assembly: AssemblyCompany("Cuby3212")]
[assembly: AssemblyProduct("Adobe Process Cleaner")]
[assembly: AssemblyCopyright("Open Source - Licencia MIT")]
[assembly: AssemblyVersion("1.1.0.0")]
[assembly: AssemblyFileVersion("1.1.0.0")]

namespace AdobeCleaner {
    class Program {
        // Excluye el lector PDF y el instalador.
        static readonly string[] ProcessNames = {
            "Creative Cloud", "Adobe Desktop Service", "Creative Cloud Helper",
            "Creative Cloud UI Helper", "CCXProcess", "CCLibrary", "CoreSync",
            "AdobeIPCBroker", "CEPHtmlEngine", "AdobeUpdateService", "AdobeARM",
            "acrotray", "AcrobatNotificationClient", "AdobeCollabSync",
            "AdobeNotificationClient", "AGSService", "AGMService", "AdobeGCClient",
            "LogTransport2", "AdobeExtensionsService", "Adobe Crash Processor",
            "armsvc", "AGCInvokerUtility", "agshelper", "Adobe CEF Helper",
            "Adobe Spaces Helper"
        };

        static int Main(string[] args) {
            bool listOnly = false;
            bool pause = !Console.IsInputRedirected;
            foreach (string arg in args) {
                if (arg == "--list") listOnly = true;
                else if (arg == "--no-pause") pause = false;
                else {
                    Console.Error.WriteLine("Uso: AdobeProcessCleaner.exe [--list] [--no-pause]");
                    return 2;
                }
            }
            Console.Title = "Adobe Process Cleaner";
            Console.WriteLine("===================================================");
            Console.WriteLine(listOnly ? "    Procesos de Adobe detectados..." :
                "    Cerrando procesos de Adobe en segundo plano...");
            Console.WriteLine("===================================================\n");
            int result = CleanProcesses(ProcessNames, listOnly);
            if (pause) {
                Console.WriteLine("\nPresiona cualquier tecla para cerrar esta ventana...");
                Console.ReadKey(true);
            }
            return result;
        }

        internal static int CleanProcesses(string[] names, bool listOnly) {
            int total = 0;
            int failed = 0;
            foreach (string name in names) {
                foreach (Process process in Process.GetProcessesByName(name)) {
                    using (process) {
                        try {
                            if (process.HasExited) continue;
                            if (listOnly) {
                                Console.WriteLine("[?] {0} (PID {1})", name, process.Id);
                                total++;
                                continue;
                            }
                            process.Kill();
                            if (!process.WaitForExit(3000)) {
                                Console.WriteLine("[!] Sin confirmar el cierre: {0} (PID {1})", name, process.Id);
                                failed++;
                                continue;
                            }
                            Console.WriteLine("[X] Proceso cerrado: {0} (PID {1})", name, process.Id);
                            total++;
                        } catch (Win32Exception ex) {
                            Console.WriteLine("[!] No se pudo cerrar {0}: {1}", name,
                                ex.NativeErrorCode == 5 ? "acceso denegado; prueba como administrador." : ex.Message);
                            failed++;
                        } catch (InvalidOperationException) {
                            // El proceso termino mientras se comprobaba.
                        }
                    }
                }
            }
            Console.WriteLine("\nTotal de procesos {0}: {1}", listOnly ? "detectados" : "cerrados", total);
            if (failed > 0) Console.WriteLine("Procesos sin cierre confirmado: {0}", failed);
            return failed == 0 ? 0 : 1;
        }
    }
}
