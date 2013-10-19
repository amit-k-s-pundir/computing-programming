#!/bin/bash

logFile=/home/sonu/files_deleted.txt

for file in $@;
do echo "Working on $file";
    echo "**************" >> ${logFile}
    echo "**************" >> ${logFile}
    ls -l $file >> ${logFile}
    echo "Deleting directory `pwd`/${file} at `date`." >> ${logFile}
    rm -Rf ${file}
    done