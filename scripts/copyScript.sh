#!/bin/bash
# This script will extract all the AC programs from the jutge tar
MYPWD=${PWD}
NAME=patron
cd $NAME
for folder in *
do
  echo "Processing $MYPWD/$NAME/$folder folder..."
  cd ${MYPWD}/$NAME/$folder
  for file in *
  do
    if [[ "$file" == *AC.cc ]]; then
      echo "Copying $file file"
      cp "$PWD/$file" "$MYPWD/programs/$NAME-$folder-$file"
    fi
  done
  cd ..
done
cd ..
