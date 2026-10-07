# reporte.ps1 - Reporte de servicios y procesos en un solo archivo CSV
$salida = Join-Path $HOME ("reporte_sistema_{0}.csv" -f (Get-Date -Format "yyyy-MM-dd"))

$servicios = Get-Service |
    Where-Object Status -eq 'Running' |
    ForEach-Object {
        [pscustomobject]@{
            Tipo        = 'Servicio'
            Nombre      = $_.Name
            Descripcion = $_.DisplayName
            Valor       = [string]$_.Status
        }
    }

$procesos = Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 10 |
    ForEach-Object {
        [pscustomobject]@{
            Tipo        = 'Proceso'
            Nombre      = $_.ProcessName
            Descripcion = "PID $($_.Id)"
            Valor       = [math]::Round([double]$_.CPU, 1)
        }
    }

@($servicios) + @($procesos) | Export-Csv -Path $salida -NoTypeInformation -Encoding UTF8
Write-Host "Reporte generado: $salida"
Write-Host ("Servicios en ejecucion: {0} | Procesos listados: {1}" -f @($servicios).Count, @($procesos).Count)
