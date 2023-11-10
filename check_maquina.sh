#!/bin/bash

hosts=('ip1'
'ip2')

VERDE='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color


for host in "${hosts[@]}"
do

if ping -q -c 4 $host >/dev/null
        then
        ping_result="${VERDE}ENCENDIDO${NC}"
else
        ping_result="${RED}APAGADO${NC}"
fi

printf "IP $host, resultado: , $ping_result \n"
done
