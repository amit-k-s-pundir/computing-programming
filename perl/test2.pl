#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  test2.pl
#
#        USAGE:  ./test2.pl  
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
#      CREATED:  Wednesday 24 February 2010 05:30:27  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature "switch";
use feature ":5.10";

#&print_env;
say $ENV{PWD};

sub print_env{
    my @keys = keys %ENV;
    my @values = values %ENV;
    foreach my $value (@values) {
        say $value;
    }
}

1;


=begin  BlockComment  # BlockCommentNo_1

print("sonu" . " sonu ", "\n");

sub test{
    print "sonu\n";

    sub nested_test1{
        print "...in nested-test1\n";
    }

    nested_test1;

    &nested_test2;

    sub nested_test2{
        say "...in nested-test2.";
    }

    return 5;
}

print((my $x = test), "\n");

my @arr = (1, 2, 3, 4, 5);
print(join("\n", map {my $x = 2;
        my $y = $x + 5;
        $_ = $_ + $y;} @arr), "\n");
        */

=end    BlockComment  # BlockCommentNo_1

=cut

