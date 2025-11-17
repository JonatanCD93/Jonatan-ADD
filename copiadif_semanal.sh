#!/bin/bash
# Copia de seguridad diferencial semanal

# Variables
ORIGEN="/home"
DESTINO="/bacjonatan"

# Obtener número de semana del año
SEMANA=$(date +%V)

# Nombre del archivo de copia
NOMBRE="CopDifSem-${SEMANA}.tar.gz"

# Crear copia diferencial (solo archivos modificados desde la última copia total)
tar -g /bacjonatan/snapshot.snar -czf "${DESTINO}/${NOMBRE}" "${ORIGEN}"

# Mensaje en pantalla
echo "Copia diferencial creada: ${DESTINO}/${NOMBRE}"
