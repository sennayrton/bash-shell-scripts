#!/bin/bash
#   Programa: gestUsu.sh
#  Propósito: Altas y bajas usuarios a partir fichero
#        Uso: sudo gestUsu.sh fichUsu fechExpi
# ExitStatus: 1=>número par. erróneo; 2=>no existe/vacío fichUsu; 3=>fecha errónea
# Ej.fichero: #Fichero de mayo
#             +pepe;José García
#             -oscar

readonly FICH_LOG=/tmp/gestUsu.log
readonly EXP_REG_FECHA="20[23][[:digit:]]-([0][1-9]|1[012])-(0[1-9]|[12][[:digit:]]|3[01])"

fichUsu=$1
fechExpi=$2

if test $# -ne 2; then
  echo "Nº parámetros erróneo. Uso: sudo $0 fichUsu fechExpi(YYYY-MM-DD)"
  exit 1
fi

if ! test -s $fichUsu; then
  echo "El fichero $fichUsu no existe o está vacío"
  exit 2
fi

if echo $fechExpi |grep -Ev $EXP_REG_FECHA>/dev/null; then
  echo "La fecha $fechExpi es errónea"
  exit 3
fi

nli=0  #número línea fichUsu que se está procesando

while read li; do
  nli=$(($nli+1))
  case ${li:0:1} in  #el primer carácter indica qué hay que hacer
   +) #añadimos usuario
     login=$(echo ${li:1:99}|cut -d\; -f1)
     comen=$(echo $li|cut -d\; -f2)
     if useradd -m -e$fechExpi -c"$comen" $login; then
       echo "Añadido usuario $login ($comen), fecha exp: $fechExpi"
     else
       echo "Error en línea $nli al añadir al usuario $login ($comen), fecha exp: $fechExpi"
     fi  
     ;;
   -) #borramos usuario
     login=$(echo ${li:1:99})
     if userdel -r $login; then 
       echo "Borrado usuario $login"
     else
       echo "Error en línea $nli al borrar al usuario $login"
     fi  
     ;;
   \#) #comentario
     echo $li
     ;;  
   *) #línea errónea
     echo "Línea $nli errónea: $li"
     ;;
  esac     

done <$fichUsu >$FICH_LOG 2>&1
