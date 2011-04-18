#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  jee_utils.pl
#
#        USAGE:  ./jee_utils.pl  
#
#  DESCRIPTION:  Some utilities for automating the JEE projects.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Monday 31 May 2010 03:36:47  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature "switch";
use feature ":5.10";
package Projects;

sub setup_default_web_component_project{
    create_dir_tree("/home/sonu/workspace", {"WEB-INFO" => [{classes => []}, {lib => []}, {tags => []}, 'web.xml']});
}

sub create_dir_tree{
    my $base_dir = shift;
    my $dir_tree_ref = shift;
    my ($dir_name, $dir_children_ref) = each %{$dir_tree_ref};
    my $full_dir_path = $base_dir . "/" . $dir_name;

    mkdir $full_dir_path;

    foreach my $dir_child (@{$dir_children_ref}){
        say "In dir $full_dir_path}";
        if("HASH" eq ref($dir_child)){
            create_dir_tree($full_dir_path, $dir_child);
        }elsif("" eq ref($dir_child)){
            my $file_name = "${full_dir_path}/" . $dir_child;
            `touch $file_name`;
        }
    }
}

1;
