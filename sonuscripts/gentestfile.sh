#!/bin/bash
#===============================================================================
#
#          FILE:  gentestfile.sh
# 
#         USAGE:  ./gentestfile.sh 
# 
#   DESCRIPTION:  Generates a new *test* file in the current directory.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Tuesday 14 April 2009 07:56:13  IST IST
#      REVISION:  ---
#===============================================================================

ls ./ | awk -f ./helpers/helpergentestfile.awk | xargs touch
