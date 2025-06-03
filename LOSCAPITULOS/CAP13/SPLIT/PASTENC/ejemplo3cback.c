#include <stdio.h>
#include <stdlib.h>

#define MAX 255

int main( int argc , char *argv[])
{
 FILE *fp1,*fp2;

 char linea1[MAX][MAX];
 char linea2[MAX];
 int i =0;
 int j= 0;
 char c1=0;
 char c2=0;
/*
if ( argc != 2 )
{
  printf("\n Error ");
  printf("\n USO: pinpaste archivo1 arcnivo2 ");
  exit (1);
}

*/
if (( fp1 = fopen(argv[1],"r")) == NULL )
  {
    printf("\n No se pudo abrir el archivo: %s", argv[1]);
    exit (1);
  }
/*
if (( fp2 = fopen(argv[2],"r")) == NULL )
  {
     printf("\n No se pudo abrir el archivo: %s", argv[2]);
     exit(2);
  
}
*/
while (!feof(fp1))
{
linea1[i]=fgets(linea1,255,fp1);
i++;
       
}
n=i-1;

fclose(fp1);

for(j = 0 ; j < n; j++)
  printf("%s\n",linea1[j]);
/*
while (!feof(fp2))
{
c2=fgetc(fp2);

putchar(c2);
}
fclose(fp2);
*/
return 0;
}
