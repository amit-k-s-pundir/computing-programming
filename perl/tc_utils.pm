#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  tc_utils.pl
#
#        USAGE:  ./tc_utils.pl  
#
#  DESCRIPTION:  Utilities for helping with TopCoder work.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Wednesday 17 March 2010 03:24:21  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature "switch";
use feature ":5.10";

use File::Copy "cp", "mv";


&main;

sub main{
    &setup_tc_proj("regular_expression_parser_1.0.0.0_dev_proj", "/home/sonu/workspace/projects/tc/dev",
        "/opt/downloads", ["regular_expression*.jar"], "www.forums.topcoder.com");
}

sub setup_tc_proj{
    my($proj_name, $base_dir, $download_dir, $downloaded_files_ref, $tc_url) = @_;
    my $proj_dir = $base_dir . "/$proj_name";
    my @downloaded_files = @{$downloaded_files_ref};

    mkdir($proj_dir) unless -d $proj_dir; 
    chdir($proj_dir) or die "Problem creating and changing
    to the projects directory: $!";

    map({cp($_, $proj_dir)} map({+glob $_} map({+$download_dir . "/" .
                    $_} @downloaded_files)));    
    unless(-d $proj_dir . "/old_jars"){
        mkdir($proj_dir . "/old_jars")  or die "Can't make the directory \"old_jars\": $!";
    }
    map({cp $_, "old_jars"} glob("*.jar"));
    map({if($_ =~ /^(.+)\.jar$/){my $new_name = $1 . ".zip"; mv $_,
                $new_name;};} glob("*.jar"));
    foreach my $zip_file (glob("*.zip")){
        `unzip $zip_file -d $1` if $zip_file =~ /^(.+)\.zip$/;
    }

    say "\nProject created successfully!
    \nProject directory is: $proj_dir";
}


