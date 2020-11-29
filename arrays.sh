#!/bin/bash
# Programa: colores.sh
# Propósito: Muestra el array de colores. Uso de $* y $@
#	     La diferencia se observa cuando se usan "" y si cada 
#	     elemento contien más de una palabra

declare -a vector

animales[0]=perro
animales[1]=gato
#...
animales[5]=hormiga

primos=([0]=2 [1]=3 [2]=5 [3]=7 [9]=29)

operaciones=("+" "-" "*" "/")

colores=("ES:rojo EN:red FR:rouge" "ES:verde EN:green FR:vert" "ES:azul EN:blue FR:bleu")

#Mostrar el primer color
echo ${colores[0]}

# Mostrar el array animales
echo "El listado de animales es: ${animales[*]}"

# Mostrar el array números primos
echo -e "\nEl listado de números primos es: ${primos[@]}"

# Utilizar elementos del array de operaciones
echo -e "\nCálculo de operaciones, usando \$@ y las \"\""
for op in "${operaciones[@]}"; do echo 10 "$op" 2 = $((10 $op 2)); done

# Trabajo con el array de colores
echo -e "\nMuestra el array de colores usando \$* y las \"\""
for color in "${colores[*]}"; do echo -e "Me gusta el color:\n $color"; done

echo -e "\nMuestra el array de colores uno a uno, usando \$@ y las \"\""
for color in "${colores[@]}"; do echo "Me gusta el color $color"; done

echo -e "\nEnumera los índices que hay en el array colores"
for color in "${!colores[@]}"; do echo $color; done

echo -e "\nTamaño del array colores: ${#colores[@]}"

# Añadir elementos al array 
colores[3]="ES:naranja EN:orange FR:orange"
colores+=("ES:rosa EN:pink FR:rose" "ES:morado EN:purple FR:violet")

# Eliminar un elemento del array de colores
unset "colores[1]"

#Mostrar el array de colores
echo -e "\nMuestra el array de colores uno a uno, usando \$@ y las \"\""
for color in "${colores[@]}"; do echo "Me gusta el color $color"; done

