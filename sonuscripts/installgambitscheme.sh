#!/bin/bash
#===============================================================================
#
#          FILE:  installgambitscheme.sh
# 
#         USAGE:  ./installgambitscheme.sh 
# 
#   DESCRIPTION:  install gambit scheme.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Sunday 09 August 2009 11:41:56  IST IST
#      REVISION:  ---
#===============================================================================

workingDir=${1}
workingDir=${workingDir:="/opt/lisp/scheme/"}
pushd ${workingDir}
echo "Inside directory ${workingDir} ..."
wget -N -c http://www.iro.umontreal.ca/~gambit/download/gambit/v4.5/source/gambc-v4_5_1.tgz
echo "Done ..."
popd
./configure --prefix=/opt/lisp/scheme/gambit --enable-single-host --enable-cplusplus
make
sudo make install
