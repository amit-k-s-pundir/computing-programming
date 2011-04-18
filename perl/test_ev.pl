#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  test_ev.pl
#
#        USAGE:  ./test_ev.pl  
#
#  DESCRIPTION:  Just playing with EV (libev).
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Friday 05 November 2010 01:56:48  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


use EV;

my $w = EV::timer 2, 0, sub {
    warn "is called after 2s";
};

EV::loop;
