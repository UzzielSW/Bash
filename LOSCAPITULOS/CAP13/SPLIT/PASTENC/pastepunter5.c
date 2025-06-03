#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define  MAX   20
#define  MAX2  81 

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
 int  verdad = 1;
   FILE *fichero1, *fichero2;



if ( argc != 3 )
{
  printf("\n Error ");
  printf("\n USO: a.out archivo1 arcnivo2 \n");
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
	               			

	nombreLargo = (char **)malloc(MAX*sizeof(char *));
	nombreLargo[0] = (char *)malloc(MAX*MAX2*sizeof(char ));
        for(i =1; i< MAX; i++)
		
		nombreLargo[i]= nombreLargo[0] + i * MAX2;


	cadena1 = (char **)malloc(MAX*sizeof(char *));
	cadena1[0] = (char *)malloc(MAX*MAX2*sizeof(char ));

        for(i =1; i< MAX; i++)
		
		cadena1[i]= cadena1[0] + i * MAX2;

	cadena2 = (char **)malloc(MAX*sizeof(char *));
	cadena2[0] = (char *)malloc(MAX*MAX2*sizeof(int ));

        for(i =1; i< MAX; i++)
		
		cadena2[i]= cadena2[0] + i * MAX2;

while (verdad == 1)     
 {
 for(i = 0 ; i < MAX; i++)
 {
    for(j = 0; j < MAX2; j++)
     {
      c =fgetc(fichero1) ;

       if(feof(fichero1))
         {
          verdad = 0; // para terminar
         break; //rompe el for j  
         }
      cadena1[i][j] = c; 
     printf("%c",cadena1[i][j] );
     if( cadena1[i][j] == '\n')
     {
     k1++; // cuento las lineas del fichero1
     break; // rompe el for j
    }
   } //fin del for j
 if ( verdad == 0 )
      break; //rompe el for i
  }
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


verdad= 1;
while (verdad == 1)     
 {
 for(i = 0 ; i < MAX; i++)
 {
    for(j = 0; j < MAX2; j++)
     {
      c =fgetc(fichero2) ;

       if(feof(fichero2))
         {
          verdad = 0;
         break;
         }
      cadena2[i][j] = c; 
     printf("%c",cadena2[i][j] );
     if( cadena2[i][j] == '\n')
     {
     k2++;
     break;
    }
   } //fin del for j
 if ( verdad == 0 )
      break; //rompe el for i
  }
}

fclose(fichero2);

n = max(k1,k2);
 printf("\n %d = max(%d,%d)\n",n,k1,k2);

for ( i=0 ; i <  n; i++ )
{ 
 m = strlen(cadena1[i]);
       cadena1[i][m-1] = '\0';

  strcpy(nombreLargo[i],cadena1[i]);

  strcat(nombreLargo[i]," ");
  m = strlen(cadena2[i]);
       cadena2[i][m] = '\0';
 strcat(nombreLargo[i],cadena2[i]);
  m = strlen(nombreLargo[i]);
      nombreLargo[i][m-1] = '\0';
 if ( nombreLargo[i] != '\0') 
     printf("%s\n",nombreLargo[i]);
}
	free(cadena1);	
	free(cadena2);	
	free(nombreLargo);	
   return 0;
}
