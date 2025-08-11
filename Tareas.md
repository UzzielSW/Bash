- variables:
  - $? exito o no
  - $# numero de argumentos
  - $\* nombre de los argumentos
  - $$ numero del proceso de la terminal del usuario
- revisar el manejo de parametros, archivos(busca, agrega[2,3], remover[2,3])

## cosas mencionadas

- getopts (si los argumentos son validos)
- buscar exactamnte aun patron usando grep:
  - grep -w apino
  - grep "\<apino\>"

set -euo pipefail # Mejores practicas: manejo robusto de errores
