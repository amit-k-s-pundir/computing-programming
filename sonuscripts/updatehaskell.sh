#!/bin/bash

read -p "Enter the name of the directory containing ghc [~/programming/haskell/]:" default_directory;
default_directory=${default_directory:=/home/sonu/programming/haskell/};
pushd ${default_directory}

# Update the main Haskell page
wget -c -p -N http://haskell.org/haskellwiki/;
# Update the GHC page.
wget -c -p -N http://haskell.org/haskellwiki/GHC/;	
wget -c -N http://www.haskell.org/ghc/docs/latest/users_guide.html.tar.bz2
wget -c -N http://www.haskell.org/ghc/docs/latest/libraries.html.tar.bz2
wget -c -N http://www.haskell.org/ghc/docs/latest/Cabal.html.tar.bz2

popd;
