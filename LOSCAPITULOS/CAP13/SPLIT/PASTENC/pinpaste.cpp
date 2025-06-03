#include <stdio.h>

int main( int argc , char *argv[])
{
 FILE *fp1,*fp2;
 int i =0;
/*
if ( argc != 2 )
{
  printf("\n Error ");
  printf("\n USO: pinpaste archivo1 arcnivo2 ");
  exit 1;
}

i*/
if ( fp1 = fopen(argv[0]),"r")) == NULL )
  {
    printf("\n No se pudo abrir el archivo: %s", argv[0]);
    exit (1);
  }
/*
if ( fpr2 = fopen(argv[1]),"r")) == NULL )
  {
     printf("\n No se pudo abrir el archivo: %s", argv[1]);
     exit(2);
  }
*/     
while (!feof(fp1))
{
fscanf(fp1,"%s",linea1);
printf("%d. %s",++i, linea1);
}
fclose(fp1);
return 0;
}
