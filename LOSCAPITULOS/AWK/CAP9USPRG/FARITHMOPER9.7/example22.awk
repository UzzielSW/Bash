clear
awk '$5 == "saving" { printf "%3d %-10s %-5d %-10s %6.2f\n",$1,$2,$3,$4,$3*0.05 } ' bank.lst
