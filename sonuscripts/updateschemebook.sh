#!/bin/bash
#===============================================================================
#
#          FILE:  updateschemebook.sh
# 
#         USAGE:  ./updateschemebook.sh 
# 
#   DESCRIPTION:  Download and/or update 'the htdp book' (http://www.htdp.org/2003-09-26/Book/) and 'the
#   scheme programming language' book (http://www.scheme.com/tspl4/index.html).
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Friday 29 October 2010 01:09:32  IST IST
#      REVISION:  ---
#===============================================================================

pushd ${work_dir:-"/home/sonu/programming/lisp/scheme/docsandbooks/"}

wget -N -c -p -k -r -l 2
