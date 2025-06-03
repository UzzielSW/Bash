#include <stdio.h>
#include <stdlib.h>

#define MAX 255

int main( int argc , char *argv[])
{
 FILE *fp1,*fp2;
 char linea1[MAX];
 int i =0;
 char c=0;

if ( argc != 3 )
{
  printf("\n Error ");
  printf("\n USO: pinpaste archivo1 arcnivo2 ");
  exit (1);
}


if (( fp1 = fopen(argv[1],"r")) == NULL )
  {
    printf("\n No se pudo abrir el archivo: %s", argv[1]);
    exit (1);
  }

if (( fp2 = fopen(argv[2],"r")) == NULL )
  {
     printf("\n No se pudo abrir el archivo: %s", argv[2]);
     exit(2);
  }
while (!feof(fp1))
{
c=fgetc(fp1);
putchar(c);
}
fclose(fp1);

while (!feof(fp2))
{
c=fgetc(fp2);
putchar(c);
}
fclose(fp2);
return 0;
}
