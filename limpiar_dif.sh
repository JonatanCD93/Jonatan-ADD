#!/bin/bash
# Script de limpieza de copias diferencial

# Directorio donde se guardan las copias
DIR_BACKUP="/bacjonatan"

# Comprobamos si existen copias diferenciales
if ls "${DIR_BACKUP}"/CopDifSem-* 1>/dev/null 2>&1; then
    rm -f "${DIR_BACKUP}"/CopDifSem-*
    echo "Limpieza realizada: eliminadas copias diferenciales en ${DIR_BACKUP}"
else
    echo "No se encontraron copias diferenciales en ${DIR_BACKUP}"
fi
