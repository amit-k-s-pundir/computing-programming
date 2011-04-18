#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  java_utils.pl
#
#        USAGE:  ./java_utils.pl  
#
#  DESCRIPTION:  Utilities for generating Java code.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Friday 19 March 2010 12:41:22  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


use feature "switch";
use feature ":5.10";

main();

sub main{
    print  write_java_class( {name => "TestClass", access => "public", storage =>"",
            superclasses => ["superclass1", "superclass2"], interfaces =>
            ["interfaces1", "interfaces2"], fields => {x => {type => "boolean", val =>
                "true", access => "private", storage => "static", annot =>
                "<ab>"}}, funs => {func1 => {type => "fun", ret_type => "void", args =>
                {arg1 => "int", arg2 => "double"}, access => "public"}}});
}

sub write_java_type{
my $source_ref = shift;
my %source = %$source_ref;

# pis = print_if_set
sub pis{
my %hash = %{shift};
my $kw = shift;

$hash{$kw}? " $hash{$kw}" : "";
}

my $output = $source{access} . ($source{storage}? " $source{storage}" : ""). "
$source{type_kind}" . " $source{name}" . ($source{interfaces}? " implements ". join(', ', @{$source{interfaces}}) : "") .
($source{superclasses}? " extends " . join(', ', @{$source{superclasses}}) : "") .
    "{\n";

    foreach my($field) (keys %{$source{fields}}){
write_field($source{fields}{$field});
}

    foreach my($key, $val) (%source){
        given($key){
            when($key =~ /^name$/){
            
    return $output;
}

