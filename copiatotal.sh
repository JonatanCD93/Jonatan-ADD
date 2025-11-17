#!/bin/bash
# ---------------------------------------------------------
# Script de copia de seguridad TOTAL mensual
# Crea archivo: CopTot-NombreMes-Año.tar.gz
# ---------------------------------------------------------

# Directorios
ORIGEN="/home"
DESTINO="/bacjonatan"

# Obtener nombre completo del mes y año
MES=$(date +%B)
ANO=$(date +%Y)

# Nombre del archivo de copia total
NOMBRE="CopTot-${MES}-${ANO}.tar.gz"

# Crear copia total (sin archivo de snapshot)
tar -czf "${DESTINO}/${NOMBRE}" "${ORIGEN}"

echo "Copia TOTAL creada: ${DESTINO}/${NOMBRE}"
