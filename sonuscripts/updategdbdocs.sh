#!/bin/bash
#===============================================================================
#
#          FILE:  updategdbdocs.sh
# 
#         USAGE:  ./updategdbdocs.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Thursday 01 April 2010 01:28:30  IST IST
#      REVISION:  ---
#===============================================================================

work_dir=${1:-"/home/sonu/programming/candcplusplus/gdb/"}
pushd ${work_dir}
wget -EN -ckp http://sourceware.org/gdb/current/onlinedocs/gdb.pdf.gz
popd

