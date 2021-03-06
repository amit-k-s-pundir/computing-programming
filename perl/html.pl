#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  html.pl
#
#        USAGE:  ./html.pl  
#
#  DESCRIPTION:  A utility to generate a basic xhtml template.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Tuesday 18 May 2010 12:24:47  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature "say";
use feature "switch";
use feature ":5.10";

use XML::Writer;
use IO::File;

my $output = new IO::File(">output.xml");
my $writer = new XML::Writer(OUTPUT => $output);
$writer->startTag("greeting", "class" => "simple");
$writer->characters("Hello, World!");
$writer->endTag("greeting");
$writer->end();
$output->close();

#sub set_up_html_file($

