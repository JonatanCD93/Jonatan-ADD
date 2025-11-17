# Muestra inicios de sesión entre dos fechas (excluyendo SYSTEM)

param(
    [Parameter(Mandatory=$true)]
    [datetime]$FechaInicio,

    [Parameter(Mandatory=$true)]
    [datetime]$FechaFin
)

Write-Host "Eventos de Inicio de Sesión:"
Write-Host ""

# Obtener eventos de inicio de sesión del registro Security (EventID 4624)
try {
    $eventos = Get-WinEvent -FilterHashtable @{
        LogName = 'Security'
        ID = 4624
        StartTime = $FechaInicio
        EndTime = $FechaFin
    } -ErrorAction SilentlyContinue | Where-Object {
        $_.Properties[5].Value -notmatch "SYSTEM" -and
        $_.Properties[5].Value -notmatch "LOCAL SERVICE" -and
        $_.Properties[5].Value -notmatch "NETWORK SERVICE" -and
        $_.Properties[5].Value -ne "" -and
        $_.Properties[5].Value -ne "-"
    }

    if ($eventos -and $eventos.Count -gt 0) {
        foreach ($evento in $eventos) {
            $fecha = $evento.TimeCreated.ToString("MM/dd/yyyy HH:mm:ss")
            $usuario = $evento.Properties[5].Value
            Write-Host "Fecha: $fecha - Usuario: $usuario"
        }
    }
    else {
        Write-Host "No se encontraron inicios de sesión en el período especificado."
        Write-Host ""
        Write-Host "SUGERENCIA: Ejecuta como ADMINISTRADOR y usa fechas más amplias (últimos 30 días)"
    }
}
catch {
    Write-Host "Error: $_"
    Write-Host "NOTA: Ejecuta PowerShell como ADMINISTRADOR para acceder al registro Security"
}
