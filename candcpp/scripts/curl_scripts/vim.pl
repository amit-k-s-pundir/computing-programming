#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  vim.pl
#
#        USAGE:  ./vim.pl  
#
#  DESCRIPTION:  Vim help file to generate perl scripts.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Thursday 01 July 2010 07:39:42  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


#use VIM::Msg;

gen_cpp_program(\@includes, \@subs, \@types, \&main);

sub gen_cpp_program{

1;

VIM::Msg("hello");
