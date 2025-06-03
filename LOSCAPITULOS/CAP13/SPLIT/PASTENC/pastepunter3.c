#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define  MAX 81
#define  MAX2 255

#define max(x,y) (( x >= y ) ? x : y )

int main(int argc, char *argv[])
{
 static char  **nombreLargo;
 static  char **cadena1;
 static  char **cadena2;
   int i = 0;
   int j = 0 ;
   int n = 0;
   int k = 0;
   int m = 0;
   int k1= 0;
   int k2= 0;
   FILE *fichero1, *fichero2;



if ( argc != 3 )
{
  printf("\n Error ");
  printf("\n USO: a.out archivo1 arcnivo2 ");
  return(1);
}


if (( fichero1 = fopen(argv[1],"r")) == NULL )
  {
    printf( "\nError (NO ABIERTO)\n" );
    printf("\n No se pudo abrir el archivo: %s", argv[1]);
    return (2);
  }
   else
   {
      printf( "\nexiste %s --> (ABIERTO)\n",argv[1] );
   }
/************/	               			
nombreLargo = (char **)malloc(MAX2*sizeof(char *));
   
for(j =0; j < MAX; j++)
		
   nombreLargo[j]=(char *)malloc(MAX2 * sizeof(char));
 
/************/	               			
cadena1 = (char **)malloc(MAX2*sizeof(char *));
   
for(j =0; j < MAX; j++)
		
   cadena1[j]=(char *)malloc(MAX2 * sizeof(char));
 
/************/	               			
cadena2 = (char **)malloc(MAX2*sizeof(char *));
   
for(j =0; j < MAX; j++)
		
   cadena2[j]=(char *)malloc(MAX2 * sizeof(char));
 

j=0;
while ( ! feof(fichero1)     )
 {
 fgets(cadena1[i++],MAX,fichero1) ;
 if( cadena1[i-1] != NULL )
 // printf("%s",fgets(cadena1[i++],81,fichero1) );
  printf("%s",cadena1[i-1] );
   k1++;
 }
fclose(fichero1);

if (( fichero2 = fopen(argv[2],"r")) == NULL )
  {
    printf( "\nError (NO ABIERTO)\n" );
    printf("\n No se pudo abrir el archivo: %s", argv[2]);
    return (1);
  }
   else
   {
      printf( "\nexiste %s --> (ABIERTO)\n",argv[2] );
   }

while ( ! feof(fichero2)     )
 {
  fgets(cadena2[j++],MAX, fichero2) ;
  if( cadena2[j-1] != NULL )
     printf( "%s",cadena2[j-1]);

   k2++;
 //  printf( "%s",fgets(cadena2[j++],81, fichero2) );
    
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
       cadena2[i][m] = '\0';
  strcat(nombreLargo[i],cadena2[i]);

  m = strlen(nombreLargo[i]);
       nombreLargo[i][m-1] = '\0';
 if ( nombreLargo[i] != NULL ) 
     printf("\n%s",nombreLargo[i]);
}
 	for(j =0; j < MAX; j++)		     
        	free(cadena1[j]);
	free(cadena1);	

 	for(j =0; j < MAX; j++)		     
		free(cadena2[j]);
	free(cadena2);	
 	for(j =0; j < MAX; j++)		     
		free(nombreLargo[j]);
	free(nombreLargo);	
   return 0;
}
