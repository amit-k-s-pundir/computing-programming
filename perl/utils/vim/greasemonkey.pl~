#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  greasemonkey.pl
#
#        USAGE:  ./greasemonkey.pl  
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
#      CREATED:  Tuesday 25 January 2011 06:29:56  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


use feature ":5.10";
use feature "switch";
#use VIM::GreaseMonkey;
&main;

package VIM::Greasemonkey;

sub gen_banner{
    my($name, $namespace, $description, $include) = @_;
    say <<"EOF";
    // ==UserScript==
    // \@name    $name
    // \@namespace  $namespace
    // \@description  $description
    // \@include  $include
    // ==/UserScript

EOF
}

sub main{
    gen_banner "name", "ns", "desc", "include";
}

1;
