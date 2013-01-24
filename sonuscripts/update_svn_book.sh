#!/bin/bash
#===============================================================================
#
#          FILE:  update_svn_book.sh
# 
#         USAGE:  ./update_svn_book.sh 
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
#       CREATED:  Sunday 02 May 2010 05:02:37  IST IST
#      REVISION:  ---
#===============================================================================

work_dir=${1:-"/home/sonu/programming/svn"}
pushd ${work_dir}
wget -N -c http://svnbook.red-bean.com/en/1.5/svn-book-html.tar.bz2
popd ${work_dir}
