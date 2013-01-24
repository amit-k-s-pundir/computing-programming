#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  update_scheme_books.pl
#
#        USAGE:  ./update_scheme_books.pl  
#
#  DESCRIPTION: Download and/or update 'the htdp book' (http://www.htdp.org/2003-09-26/Book/) and 'the
#   scheme programming language' book (http://www.scheme.com/tspl4/index.html).
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Friday 29 October 2010 01:23:21  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature "switch";
use feature ":5.10";

use Cwd;

#use libpl;
#use utilities;

my($htdp_url, $tspl_url) = ("http://www.htdp.org/2003-09-26/Book/",
    "http://www.scheme.com/tspl4/index.html");
    
my $work_dir = "/home/sonu/programming/lisp/scheme/docsandbooks/";

foreach my $url ($htdp_url, $tspl_url){
    &download_url($url, $work_dir);
}


sub download_url{
    my($url, $work_dir) = @_;

    defined($url) or die "The url to download has not been given!: $!";
    defined($work_dir) or die "The directory to download to has not been given!: $!";

    my $original_dir = getcwd();
    chdir $work_dir;
    say "In dir: " . getcwd();
    my $cmd = "/bin/bash -c \"wget -N -c -p -k -r -l 2 $url\"";
    `$cmd`;
    chdir $original_dir;
    say "Back to dir: " . getcwd();
}

1;
