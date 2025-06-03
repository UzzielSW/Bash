#include <stdio.h>
#include <string.h>
#define  MAX 81
#define  MAX2 162

#define max(x,y) (( x >= y ) ? x : y )

int main(int argc, char *argv[])
{
   char nombreLargo[MAX][MAX2];
   char cadena1[MAX][MAX];
   char cadena2[MAX][MAX];
   int i = 1;
   int j = 1 ;
   int n = 0;
   int n2 = 0;
   int k = 0;
   int m = 0;
   int k1= 0;
   int k2= 0;
   FILE *fichero1;



if ( argc != 3 )
{
  printf("\n Error ");
  printf("\n USO: a.out archivo1 arcnivo2 ");
  return(1);
}

while( i < argc )
{ 
 k1 = 0;

if (( fichero1 = fopen(argv[i],"r")) == NULL )
  {
    printf( "\nError (NO ABIERTO)\n" );
    printf("\n No se pudo abrir el archivo: %s", argv[i]);
    return (2);
  }
   else
   {
      printf( "\nexiste %s --> (ABIERTO)\n",argv[i] );
   }
n2=0;
while ( ! feof(fichero1)     )
 {
  printf("%s",fgets(cadena1[n2++],81,fichero1) );
 //  fgets(cadena1[i++],81,fichero1) ;
   k1++;
 }
fclose(fichero1);

//n = max(n,k1);

for (k=k2, j=0 ; j < n  + k1 ; j++,k++ )
{ 
  m = strlen(cadena1[j]);
       cadena1[j][m] = '\0';

    strcpy(nombreLargo[k],cadena1[j]);
    strcat(nombreLargo[k],"  ");
    strcat(nombreLargo[k],cadena1[j]);
 
    strcat(nombreLargo[k],"  ");

  m = strlen(nombreLargo[k]);
       nombreLargo[k][m] = '\0';
}
k2=k ;
n = k;
i++;
};
for (k=0 ;nombreLargo[k] != NULL  ; k++ )
     printf("\n%s",nombreLargo[k]);
   return 0;
}
