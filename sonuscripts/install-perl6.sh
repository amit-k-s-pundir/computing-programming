#!/bin/bash

currentDir=`pwd`
cd "/opt/downloads"

wget -c http://rakudo.org/downloads/star/rakudo-star-2016.07.tar.gz
tar xfz rakudo-star-2016.07.tar.gz 
cd  rakudo-star-2016.07
perl Configure.pl --gen-moar --prefix /opt/rakudo-star-2016.07     
make install

cd ${currentDir}

