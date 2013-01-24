#!/bin/bash
#===============================================================================
#
#          FILE:  download_php_src_latest.sh
# 
#         USAGE:  ./download_php_src_latest.sh 
# 
#   DESCRIPTION:  Downloads the latest stable source from the official php site.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Tuesday 21 December 2010 11:56:51  IST IST
#      REVISION:  ---
#===============================================================================

working_dir="/home/sonu/programming/php"
download_url="http://in2.php.net/get/php-5.3.4.tar.bz2/from/in.php.net/mirror"
#wget -EHKN -cpk "$download_url"
pushd $working_dir
wget -N -c "$download_url"
working_dir="${working_dir}/php_src"
pushd $working_dir
./configure --help
popd
popd
