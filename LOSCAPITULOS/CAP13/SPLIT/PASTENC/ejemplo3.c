#include <stdio.h>

int main()
{
   char nombre[10]="clot.dat", linea[81];
   FILE *fichero;

   fichero = fopen( nombre, "r" );
   printf( "Fichero: %s -> ", nombre );
   if( fichero )
      printf( "existe (ABIERTO)\n" );
   else
   {
      printf( "Error (NO ABIERTO)\n" );
      return 1;
   }
while ( ! feof(fichero))
 {
 //  printf( "La primera linea del fichero: %s\n\n", nombre );
   printf( "%s", fgets(linea, 81, fichero) );
}
fclose(fichero);
   return 0;
}
