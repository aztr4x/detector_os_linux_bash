#!/bin/bash

echo "Bienvenido al sistema de escaneo automatico"

while true; do
    echo "Selecciona una opcion: "
    echo "1.Escanear una IP"
    echo "2.Detectar el OS segun el TTL"
    echo "3.Salir"

    read -p "Introduce tu eleccion: " eleccion

    case $eleccion in 
        1)
            read -p "Introduce la IP a escanear: " ip
            echo "Escaneando $ip..."
            #Aqui pueden poner su comando segun lo necesiten
            ping -c 4 $ip
            ;;
        2)
            read -p "Introduce la IP para detectar el OS: " ip
            ttl=$(ping -c 1 $ip | grep "ttl" | cut -d " " -f 6 | cut -d "=" -f 2)
            if [ ! -z "$ttl" ]; then
                if [ $ttl -le 64 ]; then
                    echo "OS probablemente sea Linux"
                elif [ $ttl -le 128 ]; then
                    echo "OS probablemente Windows"
                else
                    echo "OS probablemente Solaris/AIX"
                fi
            else    echo "No se puedo determinar el OS"
            fi
            ;;
        3)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opcion invalida, pruea con otro valor."
            ;;
    esac
done

