#!/bin/bash
# Programa: cabecera.sh
# Propósito: Muestra una pequeña cabecera (texto centrado entre dos líneas)


# "Constantes" (preceder cada una con readonly para que realmente lo sean)
LONG_DEF=70 #tamaño por defecto de las líneas de la cabecera
CHAR_DEF="=" #carácter por defecto para las líneas de la cabecera

#Escribe una cadena de longitud $1 con el carácter $2
cadena ()
{
    local long=$1
    local char="$2"
    for((i=0; i<long; i++)) ; do
        echo -n "$char"
    done
}

#Muestra la cabecera con el texto $1 centrado entre dos líneas de 
#longitud $2 compuestas por el carácter $3
cabecera ()
{
    local texto="$1"
    local long=$2
    local char="$3"
    local longTex=${#texto}
    cadena $long "$char" #línea superior
    echo
    cadena $(( ( long - longTex ) / 2)) " " #espacios en blanco línea media

    echo "$texto" #texto línea media
    cadena $long "$char" #línea inferior
    echo
}

##PROGRAMA PRINCIPAL##
#comprobamos los parámetros pasados
case $# in
    1)
        texto="$1"
        long=$LONG_DEF
        char="$CHAR_DEF"
        ;;
    2)
        texto="$1"
        long=$2
        char="$CHAR_DEF"
        ;;
    3)
        texto="$1"
        long=$2
        char="$3"
        ;;
    *)
        echo "Parámetros erróneos. Uso: $0 texto [tamaño [carácter]]"
        ;;
esac
#Escribimos cabecera
cabecera "$texto" $long "$char"
