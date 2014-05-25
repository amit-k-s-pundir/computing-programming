#!/usr/bin/perl

use strict;

my $lengthStringPattern = 'Length: (\d+) \((\d+M)\) \[video/x-flv\]';
open(my $ifh,
     "/opt/downloads/wget-log/wget-log-1502166_hot_white_whore_sits_on_the_couch_and_deep_throats_a_hard_black_cock.flv");
while(<$ifh>){
 #   print;
    if(/$lengthStringPattern/){
	print $2, "\n;
	
    }
}
     
