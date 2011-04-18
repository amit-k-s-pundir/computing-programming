#!/bin/bash
#===============================================================================
#
#          FILE:  test.sh
# 
#         USAGE:  ./test.sh 
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
#       CREATED:  Tuesday 04 August 2009 01:01:57  IST IST
#      REVISION:  ---
#===============================================================================
#!/bin/bash
# func-cmdlinearg.sh
#  Call this script with a command-line argument,
#+ something like $0 arg1.


function func ()
{
#	baseDir=shift
#	urls="$*"
	echo ${baseDir}
#	echo ${urls}
	for url in "$@"
	do
		echo "$url"
	done

}

func "$(shift)" "$@"


