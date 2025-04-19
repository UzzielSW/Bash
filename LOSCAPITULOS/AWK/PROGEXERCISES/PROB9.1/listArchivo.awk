 awk ' BEGIN { FS="\t"
	       OFS="\t"
               } 
            { print NR":"$0 }' < data.lst
