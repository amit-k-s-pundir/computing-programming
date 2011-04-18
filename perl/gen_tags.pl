#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  gen_tags.pl
#
#        USAGE:  ./gen_tags.pl  
#
#  DESCRIPTION:  Generate tags for T1 languages, starting with Perl.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Wednesday 10 November 2010 05:35:29  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature ":5.10";
use feature "switch";
use File::Find;
use Cwd;


=begin  BlockComment  # BlockCommentNo_2

find(sub {
        say $_;
    }, "/home/sonu/workspace/programming/perl");

=end    BlockComment  # BlockCommentNo_2

=cut


my $command_1 = "/bin/bash -c \"ctags -a -l perl\"";

map {
find(sub {
#if(/\.pl$/){
        my $command = "sudo /bin/bash -c \"ctags -a -l perl" . " $_ -o /home/sonu/tags\"";
        `$command`;
        # say $command; 
        #     }
    }, $_)} @INC;

#find(\&gen_perl_tags, @INC);


=begin  BlockComment  # BlockCommentNo_1

for $file (@INC){
    $command = $command_1 . $file;
    `$command`;
}

=end    BlockComment  # BlockCommentNo_1

=cut

