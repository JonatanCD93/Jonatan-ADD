#Funcion PIZZA
function Pizza {
    $pizza = Read-Host "¿Quieres una pizza vegetariana? (Si/No)"
    if ($pizza -eq "Si") {
        Write-Host "Has elegido la pizza vegetariana"
        $ingrediente = Read-Host "Elige un ingrediente (Pimiento o Tofu)"
        if ($ingrediente -eq "Pimiento") {
            Write-Host "Su pizza es de Pimiento, Mozarella y Tomate"
        }
        if ($ingrediente -eq "Tofu") {
            Write-Host "Su pizza es de Tofu, Mozarella y Tomate"
        }
    }
    elseif ($pizza -eq "No") {
        Write-Host "Has elegido la pizza no vegetariana"
        $ingrediente = Read-Host "Elige un ingrediente (Peperoni, Jamón o salmón)"
        if ($ingrediente -eq "Peperoni") {
            Write-Host "Su pizza es de Peperoni, Mozarella y Tomate"
        }
        if ($ingrediente -eq "Jamon") {
            Write-Host "Su pizza es de Jamon, Mozarella y Tomate"
        }
        if ($ingrediente -eq "Salmon") {
            Write-Host "Su pizza es de Salmon, Mozarella y Tomate"
        }
    }
    else {
        Write-Host "Opcion invalida, por favor di Si o No"
    }
}


#Funcion DIAS
function Dias { 
    $meses = 31,29,31,30,31,30,31,31,30,31,30,31
    $pares = 0
    $impares = 0
    foreach ($diasMes in $meses) {
       for ($dia = 1; $dia -le $diasMes; $dia++) {
           if ($dia % 2 -eq 0) { 
           $pares++ 
           } else { 
           $impares++ 
             }
         }
    }
    Write-Host "Hay un total de $pares días pares"
    Write-Host "Hay un total de $impares días impares"     
}


#Funcion MENU USUARIOS
function Usuarios {
    Write-Host " "
    Write-Host "*********************"
    Write-Host "1. Listar Usuarios   "
    Write-Host "2. Crear Usuarios    "
    Write-Host "3. Eliminar usuarios "
    Write-Host "4. Modificar usuarios"
    Write-Host "*********************"
    Write-Host " "

    $opcion = Read-Host "Elige uina opción del 1 al 4, 0 para salir"
        switch ($opcion) {
        1 {$nombres = Get-ADUser -Filter *
            Write-Host $nombres.Name }
        2 {$nombre = Read-Host "Nombre del usuario"
            $pass = Read-Host -AsSecureString
            New-ADUser -Name $nombre -AccountPassword $pass }
        3 {$nombre = Read-Host "Nombre del usuario"
            Remove-ADUser -Identity $nombre }
        4 { $nombre = Read-Host "Nombre del usuario"
            $nombreNuevo = Read-Host "Nuevo nombre del usuario"
            Get-ADUser $nombre | RenameADObject -Newname $nombreNuevo}
        }
    }


#FUNCION GRUPOS
function Grupos {
    Write-Host " "
    Write-Host "*********************************"   
    Write-Host "1. Listar grupos y miembros      "
    Write-Host "2. Crear grupo                   "
    Write-Host "3. Eliminar grupo                "
    Write-Host "4. Crea miembro de un grupo      "
    Write-Host "5. Elimina un miembro de un grupo"
    Write-Host "*********************************"
    Write-Host " "

    $opcion = Read-Host "Elige una opción del menu"
    switch($opcion) {
        1 { foreach($grupo in Get-ADGroup -Filter *) {
                Write-Host "$($grupo.Name):"
                foreach($usuario in Get-ADGroupMember -Identity $grupo.Name) {
                    Write-Host "  $($usuario.Name)"
                }
                Write-Host " " }
          }

        2 { $grupo = Read-Host "Introduce el nombre del grupo a crear"
            New-ADGroup -Name $grupo -GroupScope Global}

        3 { $grupo = Read-Host "Introduce el nombre del grupo a borrar"
            Remove-ADGroup -Identity $grupo }

        4 { $grupo = Read-Host "Introduce el nombre del grupo"
            $usuario = Read-Host "Introduce el nombre del usuario"
            Add-ADGroupMember -Identity $grupo -Members $usuario }

        5 { $grupo = Read-Host "Introduce el nombre del grupo"
            $usuario = Read-Host "Introduce el nombre del usuario"
            Remove-ADGroupMember -Identity $grupo -Members $usuario }
    }
}


#FUNCION DISKP
function diskp {
    $numDisco = Read-Host "Introduce el número de disco"
    $disco = Get-Disk -Number $numDisco
    $GB = [math]::Round($disco.Size / 1GB, 2)
    Write-Host "Tamaño del disco seleccionado: $GB GB"

@"
    select disk $disco
    vale e
    clean
    convert gpt
"@ | diskpart

    $partCount = [math]::Floor($GB)
    for($i = 1; $i -le $partCount; $i++)
    {
@"
        select disk $disco
        create partition primary size=1024
"@ | diskpart
    }
}


Write-Host "******************"
Write-Host "1. Pizzas         "
Write-Host "2. Dias           "
Write-Host "3. Menu usuarios  "
Write-Host "4. Menu grupos    "
Write-Host "5. Diskp          "
Write-Host "6. Contraseña     "
Write-Host "7. Fibonacci      "
Write-Host "8. Fibonacci 2    "
Write-Host "9. Monitoreo      "
Write-Host "10. Alerta espacio"
Write-Host "******************"
Write-Host " "

$opcion = Read-Host "Elige una opcion del menu"

switch ($opcion) {
    1 {
        Pizza
    }
    2 {
        Dias
    }
    3 {
        Usuarios
    }
    4 {
        Grupos
    }
}
