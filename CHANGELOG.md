# Historial de cambios

## 1.1.0

- Se ha sustituido la llamada a PowerShell por el cierre directo desde C#.
- Se ha corregido el contador para contar cada proceso, aunque haya varias instancias con el mismo nombre.
- Ahora se confirma cada cierre y se muestran los errores cuando un proceso no se puede cerrar.
- Se han excluido el lector PDF y Adobe Installer de la lista.
- Se han añadido `--list` para consultar los procesos sin cerrarlos y `--no-pause` para terminar sin esperar una tecla.
- El ejecutable ha pasado de 369 KB a 8 KB.
- El archivo `.bat` ahora abre el ejecutable, de modo que ambos usan la misma lógica.
- Se han añadido los scripts de compilación y pruebas locales.

## 1.0.0

Primera versión pública. Permite cerrar una lista de procesos de Adobe desde consola mediante PowerShell, sin instalación ni configuración previa.
