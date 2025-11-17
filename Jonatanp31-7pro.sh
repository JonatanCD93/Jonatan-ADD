#!/bin/bash
# Archivo con la lista de programas (en el mismo directorio que el script)
LISTA="programas.txt"

# Comprobar si existe el archivo
if [ ! -f "$LISTA" ]; then
    echo "❌ No se ha encontrado el archivo $LISTA en el directorio actual."
    exit 1
fi

echo "🧹 Iniciando proceso de eliminación de programas..."
echo ""

# Leer línea por línea el archivo
while IFS= read -r programa; do
    # Saltar líneas vacías
    if [ -z "$programa" ]; then
        continue
    fi

    echo "➙ Eliminando programa: $programa..."
    sudo apt-get remove -y "$programa" >/dev/null 2>&1

    # Comprobar si la eliminación fue exitosa
    if [ $? -eq 0 ]; then
        echo "   ✔ $programa eliminado correctamente"
    else
        echo "   ⚠ No se pudo eliminar $programa (puede que no exista o ya esté eliminado)"
    fi

    echo ""
done < "$LISTA"

echo "✔️ Proceso completado."
