# Función para mostrar el menú
function Show-Menu {
    Clear-Host
    Write-Host "=== MENÚ DE EVENTOS ==="
    Write-Host "1. Eventos del sistema"
    Write-Host "2. Errores del último mes"
    Write-Host "3. Warnings de aplicaciones (semana)"
    Write-Host "4. Salir"
}

# Bucle principal
do {
    Show-Menu
    $opt = Read-Host "Elija una opción del menú: "

    switch ($opt) {
        # Opción 1: Mostrar últimos 20 eventos del sistema
        '1' {
            Write-Host "`nEVENTOS DEL SISTEMA:"
            Get-EventLog -LogName System -Newest 20 | Format-Table TimeGenerated, EntryType, Source, Message -AutoSize
            pause
        }

        # Opción 2: Mostrar errores del último mes
        '2' {
            Write-Host "`nERRORES DEL ÚLTIMO MES:"
            Get-EventLog -LogName System -EntryType Error -After (Get-Date).AddMonths(-1) | Format-Table TimeGenerated, Source, Message -AutoSize
            pause
        }

        # Opción 3: Mostrar warnings de aplicaciones de la última semana
        '3' {
            Write-Host "`nWARNINGS DE APLICACIONES (SEMANA):"
            Get-EventLog -LogName Application -EntryType Warning -After (Get-Date).AddDays(-7) | Format-Table TimeGenerated, Source, Message -AutoSize
            pause
        }

        # Opción 4: Salir del programa
        '4' { Write-Host "`nSaliendo..." -ForegroundColor Yellow }

        # Opción no válida
        default { Write-Host "Opción inválida" -ForegroundColor Red; Start-Sleep 1 }
    }
} while ($opt -ne '4')
