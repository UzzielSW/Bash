#!/bin/bash
: <<'EOF'
PROBLEMA:
Suponga que su directorio HOME es /users/steve y que tiene subdirectorios como se muestra en la figura. 

/users
├── pat
├── steve
│   ├── documents
│   │   ├── memos
│   │   │   ├── plan
│   │   │   └── dact
│   │   ├── proposals
│   │   │   ├── sys.A
│   │   │   └── new.hire
│   │   └── letters
│   │       ├── no.JSK
│   │       └── AMG.reply
│   └── programs
│       ├── wb
│       ├── collect
│       └── mon
└── ruth

Asumiendo que acaba de iniciar sesion y ejecuto:
$ docs=/users/steve/documents
$ let=$docs/letters
$ prop=$docs/proposals

Escriba comandos usando estas variables para:
a. Listar el contenido de documents.
b. Copiar todos los archivos de letters a proposals.
c. Mover archivos con nombres que contengan mayusculas de letters al directorio actual.
d. Contar el numero de archivos en memos.

Explique el efecto de:
a. ls $let/..
  Lista contenido del directorio padre de $let (documents)
b. cat $prop/sys.A >> $let/no.JSK
  Anexa contenido de sys.A al final de no.JSK
c. echo $let/\*
  Muestra los nombres de los archivos en $let (expansion del patron)
d. cp $let/no.JSK $progs
  Error: variable $progs no definida, falta destino
e. cd $prop
  Cambia al directorio $prop (proposals)
EOF

# a. Listar contenido del directorio documents
ls "$docs"

# b. Copiar todos los archivos de letters a proposals
cp "$let"/* "$prop"/ 2>/dev/null || : # Ignora errores si no hay archivos

# c. Mover archivos con mayusculas de letters al directorio actual
#    Usa expansion de patron para archivos que contengan al menos una mayuscula
mv "$let"/*[A-Z]* . 2>/dev/null || : # Ignora errores si no hay coincidencias

# d. Contar archivos en memos
#    Lista un archivo por linea y cuenta lineas
ls -1 "$docs/memos" | wc -l
