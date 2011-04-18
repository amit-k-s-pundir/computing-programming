#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  gen_xml.pl
#
#        USAGE:  ./gen_xml.pl  
#
#  DESCRIPTION:  Module to help generate xml from perl.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Tuesday 23 February 2010 11:26:38  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


sub main{
    my $xml = xml {prologue => default,
        {html 
