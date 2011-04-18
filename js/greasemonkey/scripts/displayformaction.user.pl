#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  displayformaction.user.pl
#
#        USAGE:  ./displayformaction.user.pl  
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
#      CREATED:  Thursday 27 January 2011 05:59:23  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature ":5.10";
use feature "switch";

BEGIN{
    push @INC, '/home/sonu/workspace/programming/perl/lib';
}

use Sonu::Vim::Greasemonkey;

my $buff = $curwin->Buffer();
$buff->Append(gen_banner($0, "http://localhost/greasemonkey/", "display form submission URL as a tooltip of submit
    button", ""));



