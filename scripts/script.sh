#!/bin/bash
MYPWD=${PWD}
# Stored AC problems are in programs folder
cd programs
# Result of the data is stored in $MYPWD/result.txt
rm -rf $MYPWD/result.txt
echo "ProgramName c++ O0 O1 O2 O3" >> $MYPWD/result.txt
rm -rf $MYPWD/temp/*
for file in *.cc
do
  # Pre-check, is it buildable?
  $(g++ -o $file.o $file 2> /dev/null)
  # If it builds fine, continue
  if [[ $? == 0 ]]; then
    # Print file name in the result file
    printf "%s" "$file " >> $MYPWD/result.txt
    # Print the C++ line count
    { wc -l $file; } | cut -f1 -d' ' | tr '\n' ' ' >> $MYPWD/result.txt
    # For each optimization, print the Assembler line count
    for ((i = 0; i < 4; i++));
    do
      rm -rf $MYPWD/temp/*
      echo "Running g++ -S -O$i $file"
      g++ -S -O$i -o $MYPWD/temp/$file.o $file > /dev/null
      { wc -l $MYPWD/temp/$file.o; } | cut -f1 -d' ' | tr '\n' ' ' >> $MYPWD/result.txt
    done
    # End iteration and print a newline
    echo -en "\n" >> $MYPWD/result.txt
  fi
done
cd ..
