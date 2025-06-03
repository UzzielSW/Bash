#include <stdio.h>
#include <string.h>
#define  MAX 81
#define  MAX2 162

#define max(x,y) (( x >= y ) ? x : y )

int main()
{
   char nombre1[10]="clot.dat";
   char nombre2[10]="comput.dat";
   char nombreLargo[MAX][MAX2];
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

/*
   printf("\nFichero: %s -> ", nombre1 );
   if( fichero1 )
      printf( "\nexiste (ABIERTO)\n" );
   else
   {
      printf( "\nError (NO ABIERTO)\n" );
      return 1;
   }
*/
while ( ! feof(fichero1)     )
 {
 //  printf("%s",fgets(cadena1[i++],81,fichero1) );
 fgets(cadena1[i++],81,fichero1) ;
   k1++;
 }
fclose(fichero1);

   fichero2 = fopen( nombre2, "r");
/*
   printf( "\nFichero: %s -> ", nombre2 );
   if( fichero2 )
      printf( "\nexiste (ABIERTO)\n" );
   else
   {
      printf( "\nError (NO ABIERTO)\n" );
      return 1;
   }
*/

while ( ! feof(fichero2)     )
 {
 //  printf( "%s",fgets(cadena2[j++],81, fichero2) );
 fgets(cadena2[j++],81, fichero2) ;
   k2++;
    
 }
fclose(fichero2);

n = max(k1,k2);

for ( i=0 ; i <  n; i++ )
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

