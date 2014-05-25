#!/usr/bin/perl

use strict;
use feature ":5.10";

sub wireless_working_p{
    my ($url) = @_;
    $url or $url = "192.168.1.1";
#    say $url;
    my $cmd = qq{timeout 5 ping $url};
    my $cmdOutput = `$cmd`;
    my @resultList = split /\n/, $cmdOutput;
    my ($lastLine, $secondLastLine) = (pop @resultList, pop
    @resultList);
    if($lastLine =~ /^64 bytes from $url: icmp_seq=\d+ ttl=64 time=.+ ms$/){
	return "true";
    }else{
	return 0;
    }
#    say $cmdOutput;
}

unless(wireless_working_p($ARGV[0])){
    #say "Wireless is working properly.";
    #say "Wireless is not working!";
 #   say "Restarting wireless";
    `echo "sonu" | sudo -S ~/start_wireless`;
}

