#!/bin/bash
#===============================================================================
#
#          FILE:  update_linux_docs.sh
# 
#         USAGE:  ./update_linux_docs.sh 
# 
#   DESCRIPTION:  Downloads and/or updates some basic and essential Linux docs and guides.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Friday 29 October 2010 04:01:53  IST IST
#      REVISION:  ---
#===============================================================================

declare -a urls
urls[0]="http://www.tldp.org/LDP/abs/html/abs-guide.html"
work_dir="/home/sonu/programming/linux"

pushd ${work_dir}

for url in ${urls[@]};
do wget -N -c -k -p ${url};
done

popd
