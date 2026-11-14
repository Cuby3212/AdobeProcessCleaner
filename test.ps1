$ErrorActionPreference = 'Stop'
$compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (-not (Test-Path -LiteralPath $compiler)) {
    $compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework\v4.0.30319\csc.exe'
}
New-Item -ItemType Directory -Force "$PSScriptRoot\tests\bin" | Out-Null
@'
using System;
using System.Diagnostics;
using System.IO;
using AdobeCleaner;

class CleanerTests {
    static void Assert(bool condition, string message) {
        if (!condition) throw new Exception(message);
    }
    static string Run(string name, bool listOnly) {
        TextWriter output = Console.Out;
        StringWriter capture = new StringWriter();
        try {
            Console.SetOut(capture);
            Assert(Program.CleanProcesses(new[] { name }, listOnly) == 0, "Exit code");
            return capture.ToString();
        } finally { Console.SetOut(output); }
    }
    static int Main() {
        string helper = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "APCTestSleeper.exe");
        string name = "APCTestSleeper";
        Process first = null, second = null;
        try {
            Assert(Run("APC_NoSuchProcess_9D4C", false).Contains("cerrados: 0"), "Empty result");
            first = Process.Start(new ProcessStartInfo(helper) { UseShellExecute = false, CreateNoWindow = true });
            second = Process.Start(new ProcessStartInfo(helper) { UseShellExecute = false, CreateNoWindow = true });
            string preview = Run(name, true);
            Assert(preview.Contains("detectados: 2"), "Preview count");
            Assert(!first.HasExited && !second.HasExited, "Preview killed a process");
            string cleaned = Run(name, false);
            Assert(cleaned.Contains("cerrados: 2"), "Actual count");
            Assert(first.WaitForExit(3000) && second.WaitForExit(3000), "Processes survived");
            Assert(Run(name, false).Contains("cerrados: 0"), "Repeat cleanup");
            Console.WriteLine("PASS: empty, preview, two instances, confirmed exits, repeat cleanup.");
            return 0;
        } catch (Exception ex) {
            Console.Error.WriteLine(ex);
            return 1;
        } finally {
            foreach (Process process in new[] { first, second }) {
                if (process == null) continue;
                if (!process.HasExited) { process.Kill(); process.WaitForExit(3000); }
                process.Dispose();
            }
        }
    }
}
'@ | Set-Content -LiteralPath "$PSScriptRoot\tests\bin\CleanerTests.cs" -Encoding utf8
@'
class Sleeper {
    static void Main() { System.Threading.Thread.Sleep(60000); }
}
'@ | Set-Content -LiteralPath "$PSScriptRoot\tests\bin\Sleeper.cs" -Encoding utf8

& $compiler /nologo /target:exe "/out:$PSScriptRoot\tests\bin\APCTestSleeper.exe" "$PSScriptRoot\tests\bin\Sleeper.cs"
if ($LASTEXITCODE -ne 0) { throw 'No se pudo compilar el proceso de prueba.' }
& $compiler /nologo /target:exe /main:CleanerTests "/out:$PSScriptRoot\tests\bin\CleanerTests.exe" "$PSScriptRoot\AdobeProcessCleaner.cs" "$PSScriptRoot\tests\bin\CleanerTests.cs"
if ($LASTEXITCODE -ne 0) { throw 'No se pudieron compilar las pruebas.' }
& "$PSScriptRoot\tests\bin\CleanerTests.exe"
if ($LASTEXITCODE -ne 0) { throw 'Pruebas fallidas.' }
& "$PSScriptRoot\AdobeProcessCleaner.exe" --invalid
if ($LASTEXITCODE -ne 2) { throw 'Argumentos no validados.' }

