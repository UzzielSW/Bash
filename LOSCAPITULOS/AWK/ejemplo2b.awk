ls -l |  tr -s ' ' ' ' > directorio
awk '$6 == "May" { sum +=$5} END { print sum }' directorio
