#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define  MAX 3
#define  MAX2   50

#define max(x,y) (( x >= y ) ? x : y )

int main(int argc, char *argv[])
{
 static char  **nombreLargo;
 static  char **cadena1;
 static  char **cadena2;
 int c;
   int i = 0;
   int j = 0 ;
   int n = 0;
   int k = 0;
   int m = 0;
   int k1= 0;
   int k2= 0;
   FILE *fichero1, *fichero2;


/*
if ( argc != 3 )
{
  printf("\n Error ");
  printf("\n USO: a.out archivo1 arcnivo2 ");
  return(1);
}

*/
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
/*	               			

	nombreLargo = (char **)malloc(MAX*sizeof(char *));
	nombreLargo[0] = (char *)malloc(MAX*MAX2*sizeof(char ));
        for(i =1; i< MAX; i++)
		
		nombreLargo[i]= nombreLargo[0] + i * MAX2;
*/
/*
	cadena1 = (char **)malloc(MAX*sizeof(char *));
	cadena1[0] = (char *)malloc(MAX*MAX2*sizeof(char ));

        for(i =1; i< MAX; i++)
		
		cadena1[i]= cadena1[0] + i * MAX2;
i*/ 
/************/	               			
/*

	cadena2 = (char **)malloc(MAX*sizeof(char *));
	cadena2[0] = (char *)malloc(MAX*MAX2*sizeof(int ));

        for(i =1; i< MAX; i++)
		
		cadena2[i]= cadena2[0] + i * MAX2;
 
 
              			
 
j=0;
*/
while (1)     
 {
 
 c =fgetc(fichero1) ;
 if(feof(fichero1))
 {

  break;
 }
  printf("%c",c );
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



while (1)     
 {
 
 c =fgetc(fichero2) ;
 if(feof(fichero2))
 {

  break;
 }
  printf("%c",c );
  }
 //  printf( "%s",fgets(cadena2[j++],81, fichero2) );
    
fclose(fichero2);
	free(cadena1);	

	free(cadena2);	
	free(nombreLargo);	
   return 0;
}
