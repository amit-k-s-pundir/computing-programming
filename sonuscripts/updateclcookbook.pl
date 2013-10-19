#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  updateclcookbook.pl
#
#        USAGE:  ./updateclcookbook.pl  
#
#  DESCRIPTION:  Downloads and updates the nightly  tarball of the 'The Coommon Lisp Cookbook' to a
#  directory and updates it.
#   Usage: updateclcookbook.pl $url $base_dir
#
#      OPTIONS:  --- $url : The url to download.
#                    $base_dir : The directory where the script will be run.
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Sunday 24 October 2010 01:54:04  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature "switch";
use feature ":5.10";

use Cwd;

my ($url, $work_dir) = @_;

$url = "http://cvs.sourceforge.net/cvstarballs/cl-cookbook-cvsroot.tar.bz2" unless $url;
$work_dir = "/home/sonu/programming/perl/" unless $work_dir;

my $original_dir = getcwd(); # $ENV{PWD};

chdir $work_dir;
#`pushd $base_dir`;
my $dir = getcwd();
say "In dir: $dir";
my $command = "wget -N -c $url";
`$command`;
#`popd`;
chdir $original_dir;
$dir = getcwd();
say "In dir: $dir";

1;
