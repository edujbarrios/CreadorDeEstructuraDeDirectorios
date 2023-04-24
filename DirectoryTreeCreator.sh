#!/bin/bash

if [[ $# -eq 0 ]] || [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
  echo "Este script crea una estructura de directorios y archivos a partir de un archivo de texto."
  echo "El archivo de texto debe contener una lista de directorios y archivos con el siguiente formato:"
  echo "/directorio_principal"
  echo "  directorio_secundario"
  echo "    nuevo_directorio"
  echo "    nuevo_archivo.py"
  echo "    nuevo_archivo.cpp"
  echo "Cada línea del archivo de texto representa un directorio o archivo."
  echo "Si la línea comienza con un '/' es un directorio principal, de lo contrario es un subdirectorio o un archivo."
  echo "Si el nombre de la línea contiene un punto, se considera un archivo."
  echo "Los archivos no pueden tener subdirectorios, por lo que la siguiente línea que comience con un tabulador se considera un nuevo archivo."
  echo "Cada directorio o archivo debe estar en una línea separada."
  echo "Ejemplo de archivo de texto:"
  echo "/proyecto"
  echo "  libs"
  echo "    utilidades"
  echo "      utilidades.py"
  echo "    logger"
  echo "      logger.py"
  echo "  main.py"
  exit 1
fi

if [[ -f $1 ]]; then
  while read -r line; do
    if [[ "$line" == "" ]]; then
      continue
    fi
    if [[ "$line" == "/"* ]]; then
      current_dir="$line"
      if [[ ! -d "$current_dir" ]]; then
        mkdir "$current_dir"
      fi
    else
      path="$current_dir/$line"
      if [[ "$line" == *"."* ]]; then
        touch "$path"
      else
        mkdir "$path"
        current_dir="$path"
      fi
    fi
  done < "$1"
else
  echo "Debe proporcionar el archivo de texto que contiene la estructura de directorios y archivos."
  echo "Ejemplo: ./crear_estructura.sh estructura.txt"
  exit 1
fi

echo "Estructura de directorios y archivos creada correctamente."
