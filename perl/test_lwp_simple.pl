#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  test_lwp_simple.pl
#
#        USAGE:  ./test_lwp_simple.pl  
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
#      CREATED:  Sunday 07 November 2010 07:51:32  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


use LWP::Simple;
  
my $catalog = get("http://www.oreilly.com/catalog");
die "Couldn't get it?!" unless $catalog;
my $count = 0;
$count++ while $catalog =~ m{Perl}gi;
print "$count\n";
