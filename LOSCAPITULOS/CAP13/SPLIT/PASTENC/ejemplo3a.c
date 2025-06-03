#include <stdio.h>
#include <string.h>
#define  MAX 81
#define max(x,y) (( x >= y ) ? x : y )

void agregar_cadena(char *cadena1, char *cadena2);

int main()
{
   char nombre1[10]="clot.dat", linea1[81];
   char nombre2[10]="comput.dat", linea2[81];
   char nombreLargo[20];
   char cadena1[MAX][MAX];
   char cadena2[MAX][MAX];
   int i = 0;
   int j = 0 ;
   int n = 0;
   int k = 0;
   int m = 0;
   int k1= 0;
   int k2= 0;
   FILE *fichero1, *fichero2;

   fichero1 = fopen( nombre1, "r" );

   printf("\nFichero: %s -> ", nombre1 );
   if( fichero1 )
      printf( "\nexiste (ABIERTO)\n" );
   else
   {
      printf( "\nError (NO ABIERTO)\n" );
      return 1;
   }

while ( ! feof(fichero1)     )
 {
   printf("%s",fgets(cadena1[i++],81,fichero1) );
   k1++;
 }
fclose(fichero1);

   fichero2 = fopen( nombre2, "r");

   printf( "\nFichero: %s -> ", nombre2 );
   if( fichero2 )
      printf( "\nexiste (ABIERTO)\n" );
   else
   {
      printf( "\nError (NO ABIERTO)\n" );
      return 1;
   }

  printf("\n Hola\n");

while ( ! feof(fichero2)     )
 {
   printf( "%s",fgets(cadena2[j++],81, fichero2) );
   k2++;
    
 }
fclose(fichero2);

//  agregar_cadena(nombre1, nombre2);

  strcpy(nombreLargo,nombre1);
  //strcat(nombreLargo,"  ");
  strcat(nombreLargo,nombre2);

  printf("\nnombreLargo: %s\n",nombreLargo);
   return 0;
}

void agregar_cadena(char *cadena1, char *cadena2)
{
    while( *cadena1 )
        cadena1++;

    while ( *cadena1++ = *cadena2++ );

return;
}
  

