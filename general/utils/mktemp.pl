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

my $s = `date +%H_%M_%S_%Z_%a_%d_%b_%Y`;

if (!`touch \$\(date +%H_%M_%S_%Z_%a_%d_%b_%Y\).org`) {
    print "Created the file named $s \n";
    
}

1;
