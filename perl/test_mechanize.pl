#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  test_mechanize.pl
#
#        USAGE:  ./test_mechanize.pl  
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
#      CREATED:  Monday 08 November 2010 03:04:26  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


use WWW::Mechanize;

my $url = "http://192.168.1.1/main.html";
#my $url = "http://192.168.1.1/";

my $mech = WWW::Mechanize->new();
$mech->credentials('admin', 'admin');
$mech->get($url);
$mech->follow_link(text_regex => qr/Device/i);
print $mech->text();
