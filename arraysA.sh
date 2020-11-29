#!/bin/bash

declare -A capital

# Rellenar el array
capital=([UK]="London" [Spain]="Madrid")

capital[Germany]="Berlin"
capital[Italy]="Roma"

# Agregar datos al array
capital+=([Greece]="Atenas" [Portugal]="Lisbon")

# Acceso a un elemento
echo "Acceso a la capital de Spain:  ${capital[Spain]}"

# Recorrer el array
echo -e "\nListado de paises: capitales\n----------------------------"

for pais in "${!capital[@]}"; do
	echo -e "$pais:     \t${capital[$pais]}"
done
