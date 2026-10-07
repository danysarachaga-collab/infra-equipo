#!/usr/bin/env bash
# respaldo.sh - Respaldo comprimido de ~/documentos con la fecha en el nombre
set -euo pipefail

ORIGEN="$HOME/documentos"
DESTINO="$HOME/respaldos"
FECHA="$(date +%F_%H-%M)"
ARCHIVO="$DESTINO/docs-$FECHA.tar.gz"

if [ ! -d "$ORIGEN" ]; then
    echo "ERROR: no existe la carpeta de origen: $ORIGEN" >&2
    exit 1
fi

mkdir -p "$DESTINO"
tar -czf "$ARCHIVO" -C "$HOME" documentos
echo "$(date '+%F %T') Respaldo creado: $ARCHIVO ($(du -h "$ARCHIVO" | cut -f1))"

