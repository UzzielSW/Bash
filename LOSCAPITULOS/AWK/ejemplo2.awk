ls -l |  tr -s ' ' ' ' | awk '$6 == "May" { sum +=$5} END { print sum }' 
