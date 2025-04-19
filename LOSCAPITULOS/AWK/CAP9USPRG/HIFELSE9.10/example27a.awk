clear
echo " Si el tercer campo es mayor \$3 >  10000
       el interes es \$3*.05 de otra forma el interes es \$3*0.6"
        
awk ' { if ( $3 >= 10000 )
          print NR,$0,"yes interest = "$3*.05
        else
            print NR,$0,"no  interest = "$3*.06

     }' bank.lst
echo
