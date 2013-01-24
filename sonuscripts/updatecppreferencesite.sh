#!/bin/bash
#===============================================================================
#
#          FILE:  updatecppreferencesite.sh
# 
#         USAGE:  ./updatecppreferencesite.sh 
# 
#   DESCRIPTION:  Update the local archive of http://www.cppreference.com/ site.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Thursday 07 May 2009 12:50:03  IST IST
#      REVISION:  ---
#===============================================================================

#function usage (){
#	echo "sonu";
#}

read -p "Enter the name of the working directory [current directory]:" base_directory;
base_directory=${base_directory:=`pwd`}
pushd "$base_directory"
wget -c http://www.cppreference.com/cppreference-files.tar.gz
popd
