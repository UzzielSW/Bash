BEGIN { FS ="\n"; RS=""}
{
 print($1,"\t",$NF)
}

#$NF prints last field contents


