#!/bin/bash
#   Programa: gestUsu.sh
#  Prop�sito: Altas y bajas usuarios a partir fichero
#        Uso: sudo gestUsu.sh fichUsu fechExpi
# ExitStatus: 1=>n�mero par. err�neo; 2=>no existe/vac�o fichUsu; 3=>fecha err�nea
# Ej.fichero: #Fichero de mayo
#             +pepe;Jos� Garc�a
#             -oscar

readonly FICH_LOG=/tmp/gestUsu.log
readonly EXP_REG_FECHA="20[23][[:digit:]]-([0][1-9]|1[012])-(0[1-9]|[12][[:digit:]]|3[01])"

fichUsu=$1
fechExpi=$2

if test $# -ne 2; then
  echo "N� par�metros err�neo. Uso: sudo $0 fichUsu fechExpi(YYYY-MM-DD)"
  exit 1
fi

if ! test -s $fichUsu; then
  echo "El fichero $fichUsu no existe o est� vac�o"
  exit 2
fi

if echo $fechExpi |grep -Ev $EXP_REG_FECHA>/dev/null; then
  echo "La fecha $fechExpi es err�nea"
  exit 3
fi

nli=0  #n�mero l�nea fichUsu que se est� procesando

while read li; do
  nli=$(($nli+1))
  case ${li:0:1} in  #el primer car�cter indica qu� hay que hacer
   +) #a�adimos usuario
     login=$(echo ${li:1:99}|cut -d\; -f1)
     comen=$(echo $li|cut -d\; -f2)
     if useradd -m -e$fechExpi -c"$comen" $login; then
       echo "A�adido usuario $login ($comen), fecha exp: $fechExpi"
     else
       echo "Error en l�nea $nli al a�adir al usuario $login ($comen), fecha exp: $fechExpi"
     fi  
     ;;
   -) #borramos usuario
     login=$(echo ${li:1:99})
     if userdel -r $login; then 
       echo "Borrado usuario $login"
     else
       echo "Error en l�nea $nli al borrar al usuario $login"
     fi  
     ;;
   \#) #comentario
     echo $li
     ;;  
   *) #l�nea err�nea
     echo "L�nea $nli err�nea: $li"
     ;;
  esac     

done <$fichUsu >$FICH_LOG 2>&1
