#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  mktemp.pl
#
#        USAGE:  ./mktemp.pl  
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Tuesday 31 August 2010 01:22:53  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


`touch \$\(date +%a_%e_%b_%H_%M_%S_%Z_%Y\).txt`;
1;
