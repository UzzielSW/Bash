#! /bin/bash

function lec(){
	for x in {0..$1}
	do 
		echo $x
	done
}

echo -n "Imprimir hasta (n+1): n = "
read DA
echo $(lec $DA)