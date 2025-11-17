# Menú dinámico de registros de eventos

do {
    Clear-Host
    Write-Host "=== REGISTROS DE EVENTOS ==="

    # Obtener registros disponibles
    $registros = Get-EventLog -List | Where-Object { $_.Entries.Count -gt 0 }

    # Mostrar menú numerado
    for ($i = 0; $i -lt $registros.Count; $i++) {
        Write-Host "$( $i+1 ). $( $registros[$i].Log )"
    }
    Write-Host "0. Salir"

    # Leer opción
    $opcion = Read-Host "`nOpción"

    # Procesar opción
    if ($opcion -eq '0') {
        Write-Host "Saliendo..."
    }
    elseif ($opcion -gt 0 -and $opcion -le $registros.Count) {
        $nombreRegistro = $registros[$opcion - 1].Log
        Write-Host "`n=== ÚLTIMOS 12 EVENTOS: $nombreRegistro ==="
        Get-EventLog -LogName $nombreRegistro -Newest 12 | Format-Table TimeGenerated, EntryType, Source, Message -AutoSize
        pause
    }
    else {
        Write-Host "Opción inválida"
        Start-Sleep 1
    }

} while ($opcion -ne '0')
