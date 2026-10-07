# Semana 9: Automatización con Bash, PowerShell y Python con IA

Actividad individual de Administración de Plataformas de TI (IESTP "Paiján").
Automatiza tareas básicas con scripts, programa una de ellas con cron y revisa
código generado por una IA antes de usarlo.

## Contenido

| Archivo | Lenguaje | Qué hace |
|---|---|---|
| `respaldo.sh` | Bash | Comprime `~/documentos` en un `.tar.gz` con fecha y hora en `~/respaldos` |
| `reporte.ps1` | PowerShell | Genera un CSV con los servicios en ejecución y los 10 procesos con más CPU |
| `estado_borrador.py` | Python | Borrador original generado por la IA, sin modificar |
| `estado.py` | Python | Versión revisada y corregida: equipo, disco usado y memoria libre |

## Cómo usarlo

### Bash y cron (Debian/Ubuntu)

```bash
chmod +x respaldo.sh
./respaldo.sh
ls -lh ~/respaldos
```

Programar el respaldo todos los días a las 02:00:

```bash
(crontab -l 2>/dev/null; echo '0 2 * * * $HOME/respaldo.sh >> $HOME/respaldo.log 2>&1') | crontab -
crontab -l
```

### Python

```bash
python3 -m py_compile estado.py && echo "Sintaxis OK"
python3 estado.py
```

### PowerShell (Windows)

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\reporte.ps1
Import-Csv "$HOME\reporte_sistema_*.csv" | Group-Object Tipo | Select-Object Name, Count
```

## Revisión del código de la IA

El borrador (`estado_borrador.py`) se contrastó con `df` y `free -h`:

| Dato | Borrador | Herramienta del sistema | Versión corregida |
|---|---|---|---|
| Disco usado | 93.38 % | `df`: 99 % | 99 % |
| Memoria libre | 0.077 GB (`MemFree`) | `free`: 1,4 Gi (`available`) | 1.4 GB (`MemAvailable`) |

Correcciones aplicadas: porcentaje de disco calculado como `df`, uso de
`MemAvailable`, manejo de errores con código de salida y estructura con
`main()` y `__main__`.

## Notas

- Todo se probó en un laboratorio (VM Debian y equipo Windows), no en producción.
- El repositorio no contiene contraseñas, respaldos ni registros de ejecución.
