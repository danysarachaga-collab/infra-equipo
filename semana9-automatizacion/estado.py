#!/usr/bin/env python3
"""estado.py - Reporte basico del sistema (equipo, disco y memoria)."""
import math
import shutil
import socket
import sys
from datetime import datetime


def leer_meminfo(ruta="/proc/meminfo"):
    """Devuelve los valores de /proc/meminfo como diccionario {clave: kB}."""
    datos = {}
    with open(ruta, encoding="utf-8") as archivo:
        for linea in archivo:
            clave, _, resto = linea.partition(":")
            partes = resto.split()
            if partes:
                datos[clave] = int(partes[0])
    return datos


def porcentaje_disco(ruta="/"):
    """Porcentaje de disco usado, calculado igual que 'df' (redondeado hacia arriba)."""
    uso = shutil.disk_usage(ruta)
    disponible_real = uso.used + uso.free
    return math.ceil(uso.used / disponible_real * 100)


def main():
    try:
        memoria = leer_meminfo()
        libre_gb = memoria["MemAvailable"] / 1024 / 1024
    except (OSError, KeyError) as error:
        print(f"ERROR: no se pudo leer la memoria: {error}", file=sys.stderr)
        return 1

    print(f"Equipo: {socket.gethostname()}")
    print(f"Disco usado: {porcentaje_disco()}%")
    print(f"Memoria libre: {libre_gb:.1f} GB")
    print(f"Generado: {datetime.now():%Y-%m-%d %H:%M:%S}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

