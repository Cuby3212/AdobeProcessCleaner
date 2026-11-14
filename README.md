<p align="center">
<img src="logo.png" alt="APC Logo" width="200"/>
</p>

# Adobe Process Cleaner (APC)

[Español](#español) | [English](#english)

## Español

Adobe Process Cleaner sirve para cerrar los procesos de Adobe que siguen en segundo plano después de cerrar sus aplicaciones. Es portátil: basta con abrir el ejecutable.

### Uso

1. Descarga `AdobeProcessCleaner.exe` desde [Releases](https://github.com/Cuby3212/AdobeProcessCleaner/releases/latest).
2. Guarda tu trabajo y cierra las aplicaciones de Adobe. Si hay una instalación o sincronización en curso, espera a que termine.
3. Abre el ejecutable. Al terminar, verás cuántos procesos se han cerrado y si ha habido algún error.

El programa usa una lista de procesos. Desde la versión 1.1.0, el lector PDF y `Adobe Installer` quedan fuera de ella. Los servicios no se desactivan, por lo que algunos procesos pueden volver a iniciarse. Si aparece un error de acceso denegado, puede ser necesario ejecutar el programa como administrador.

También puedes usar estas opciones:

- `--list`: muestra los procesos encontrados sin cerrarlos.
- `--no-pause`: cierra la ventana al terminar, sin esperar una tecla.

El archivo `.bat` abre el mismo programa y necesita tener el ejecutable en su carpeta. Para usarlo en scripts, los códigos de salida son `0` si termina sin errores, `1` si algún cierre no se ha podido confirmar y `2` si los argumentos son incorrectos.

### Compilar y probar

Se necesita Windows con .NET Framework 4.x, incluido en Windows 10 y 11. Puedes compilar el código y ejecutar las pruebas desde PowerShell, en la carpeta del proyecto:

```powershell
.\build.ps1
.\test.ps1
```

No hace falta instalar un SDK ni paquetes adicionales. Las pruebas abren y cierran sus propios procesos, sin cerrar los de Adobe. Desde la versión 1.1.0, el programa tampoco necesita abrir PowerShell para hacer la limpieza.

### SmartScreen

El ejecutable no tiene firma digital, así que Windows puede mostrar el aviso «Editor desconocido». Descárgalo desde este repositorio. En la release está su SHA-256 para comprobar que el archivo coincide con el publicado.

## English

Adobe Process Cleaner closes Adobe processes that keep running in the background after you close its applications. It is portable: open the executable to run it.

### Usage

1. Download `AdobeProcessCleaner.exe` from [Releases](https://github.com/Cuby3212/AdobeProcessCleaner/releases/latest).
2. Save your work and close Adobe applications. Wait for any installation or synchronization to finish.
3. Open the executable. When it finishes, it shows how many processes were closed and any errors.

The program uses a process list. As of version 1.1.0, the PDF reader and `Adobe Installer` are excluded. Services are not disabled, so some processes may restart. If an access denied error appears, you may need to run the program as administrator.

The following options are also available:

- `--list`: shows detected processes without closing them.
- `--no-pause`: exits without waiting for a keypress.

The `.bat` file opens the same program and needs the executable in its folder. For scripts, exit codes are `0` for completion without errors, `1` for unconfirmed exits, and `2` for invalid arguments.

### Build and test

Requires Windows with .NET Framework 4.x, included in Windows 10 and 11. Run these commands in PowerShell from the project folder:

```powershell
.\build.ps1
.\test.ps1
```

No additional SDK or packages are needed. Tests start and close their own processes without closing Adobe processes. As of version 1.1.0, the program no longer opens PowerShell to perform the cleanup.

### SmartScreen

The executable is unsigned, so Windows may show an “Unknown Publisher” warning. Download it from this repository. Each release includes the executable's SHA-256 so you can check that your file matches the published one.

---

Creado por / Created by Cuby3212 · [MIT](LICENSE.md) · [Cambios / Changes](CHANGELOG.md)
