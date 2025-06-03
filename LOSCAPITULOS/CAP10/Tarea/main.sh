#!/bin/bash
validchoice=""
until [ !  -z  "$validchoice" ]
do
    clear
    echo  -n "
      Ud desea:
        1. Validar IP
        2. Validar numero de celular (Panamá)
        3. Validar MAC
        4. Salir
    Seleccione (1-4):   "
    read choice
    echo
    
    case  "$choice"
        in
        1) echo -n "Ingrese la IP a validar: "
            read IP
            ./valida_ip.sh "$IP"
        read pause;;
        
        2) echo -n "Ingrese el numero de celular a validar: "
            read numero
            ./valida_cell.sh "$numero"
        read pause;;
        
        3) echo -n "Ingrese la MAC a validar: "
            read MAC
            ./valida_mac.sh "$MAC"
        read pause;;
        
        
        4) echo "Adios..."
        break;;
        # validchoice="TRUE";;
        
        *) echo "Opcion Invalida";;
        
    esac
done