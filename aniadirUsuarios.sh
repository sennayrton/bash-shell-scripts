#!/bin/bash
  for row in `cat $1`
  do
      if [ $(id -u) -eq 0 ]; then
          username=${row%:*}
          password=${row#*:}
          echo "Usuario: $username"
          #echo password
          egrep "^$username" /etc/passwd >/dev/null


          if [ $? -eq 0 ]; then
              echo "$username ya existe"
              exit 1
          else
              #encriptacion de la password
              pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
              useradd -m -p $pass $username
              #el usuario deberá cambiar la password en el proximo acceso
              passwd -e $username
              [ $? -eq 0 ] && echo "$username ha sido aniadido." || echo "Error al aniadir $username"
          fi


      else
          echo "Solo el usuario root puede aniadir usuarios al sistema."
          exit 2
      fi
  done
