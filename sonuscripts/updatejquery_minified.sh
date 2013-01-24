#!/bin/bash
#===============================================================================
#
#          FILE:  updatejquery_minified.sh
# 
#         USAGE:  ./updatejquery_minified.sh 
# 
#   DESCRIPTION:  update the minified version of jquery.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Monday 03 August 2009 06:33:50  IST IST
#      REVISION:  ---
#===============================================================================

workingDir="/home/sonu/programming/javascript/jquery/"
jqueryMinifiedURL="http://code.google.com/p/jqueryjs/downloads/detail?name=jquery-1.3.2.min.js"
jqueryUncompressedURL="http://code.google.com/p/jqueryjs/downloads/detail?name=jquery-1.3.2.js"
jqueryAPIDocs="http://dev.jquery.com/view/trunk/tools/api-browser/jquery-api-browser.zip"

function usage(){
	echo "$(basename $0) dir_where_jquery_is_installed "
}

function download(){
		workingDir="$1"
		shift
	echo "...in $workingDir"

#	urls="$@"
	pushd "$workingDir"
	for url in "$@"
	do 
		echo "...downloading from $url"
		wget -N -c "$url"
	done
	popd
}
echo "$workingDir"
pushd "$workingDir"
ls
popd
download "$workingDir" "$jqueryMinifiedURL" "$jqueryUncompressedURL" "$jqueryAPIDocs"
