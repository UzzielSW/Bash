if [ "$#" -ne 1 ]
then
     echo "El numero de argumentos es incorrecto"
     echo "USO: nuevo nombre_del_usuario"
     exit 1
else
    user="$1"
    if who | grep "^$user " > /dev/null
    then
        echo "$user esta en el sistema"
    else
        echo "$user no esta en el sistema"
    fi
fi
