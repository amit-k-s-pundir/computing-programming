#!/bin/bash

${wd:="/home/sonu/programming/haskell/ghc"}

[[ ! -d ${wd} ]] && mkdir ${wd}

pushd ${wd}

wget -N -c http://legacy.cs.uu.nl/daan/download/parsec/parsec.pdf
wget -N -c http://legacy.cs.uu.nl/daan/download/parsec/parsec.html
wget -N -c http://www.haskell.org/ghc/docs/latest/users_guide.html.tar.bz2 
wget -N -c http://www.haskell.org/ghc/docs/latest/Cabal.html.tar.bz2
wget -N -c http://www.haskell.org/ghc/docs/latest/libraries.html.tar.bz2

popd ${wd}
