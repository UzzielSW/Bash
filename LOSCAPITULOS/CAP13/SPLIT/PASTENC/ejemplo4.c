#include <stdio.h>
#include <string.h>
#include <malloc.h>
#define  MAX 81
#define  MAX2 162
#define  NFILE 3

#define max(x,y) (( x >= y ) ? x : y )

int main(int argc, char *argv[])
{
   char nombreLargo[MAX][MAX2];
   char cadena1[MAX][MAX];
   char cadena2[MAX][MAX];
   int i = 0;
   int i1 = 1;
   int j = 0 ;
   int j2 = 0;
   int n = 0;
   int k = 0;
   int m = 0;
   int k1= 0;
   int k2= 0;

 FILE *fichero[NFILE];


if ( argc > 3 )
{
  printf("\n Error ");
  printf("\n USO: a.out archivo1 arcnivo2 ");
  return(1);
}

 //fichero1 = fopen(argv[1],"r");

if (( fichero[i1] = fopen(argv[i1],"r")) == NULL )
  {
    printf( "\nError (NO ABIERTO)\n" );
    printf("\n No se pudo abrir el archivo: %s", argv[i1]);
    return (2);
  }
   else
   {
      printf( "\nexiste %s --> (ABIERTO)\n",argv[i1] );
   }

while ( ! feof(fichero[i1]) )
 {
   //printf("%s",fgets(cadena1[i++],81,fichero[i1]) );
 fgets(cadena1[i++],81,fichero[i1]) ;
   k1++;
 }
fclose(fichero[i1]);

i1++;

 //fichero2 = fopen(argv[2],"r");

if (( fichero[i1] = fopen(argv[i1],"r")) == NULL )
  {
    printf( "\nError (NO ABIERTO)\n" );
    printf("\n No se pudo abrir el archivo: %s", argv[i1]);
    return (1);
  }
   else
   {
      printf( "\nexiste %s --> (ABIERTO)\n",argv[i1] );
   }
while ( ! feof(fichero[i1])     )
 {
 //  printf( "%s",fgets(cadena2[j++],81, fichero[i1]) );
 fgets(cadena2[j++],81, fichero[i1] ) ;
   k2++;
    
 }
fclose(fichero[i1]);

n = max(k1,k2);

for ( i=0 ; i <  k1; i++ )
{ 
  m = strlen(cadena1[i]);
       cadena1[i][m-1] = '\0';
       
  strcpy(nombreLargo[i],cadena1[i]);
  strcat(nombreLargo[i],"  ");
  m = strlen(cadena2[i]);
       cadena2[i][m-1] = '\0';
  strcat(nombreLargo[i],cadena2[i]);

  m = strlen(nombreLargo[i]);
       nombreLargo[i][m-1] = '\0';
 if ( nombreLargo[i] != NULL ) 
     printf("\n%s",nombreLargo[i]);
}
   return 0;
}
