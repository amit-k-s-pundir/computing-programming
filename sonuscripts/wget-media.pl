#!/usr/bin/perl

use strict;

my $url = shift;
my @arr = split(/\//, $url);
my $downloadName = pop(@arr);
my $logFileDir = "/opt/downloads/wget-log";
my $logFileName = "wget-log-" . "$downloadName" . ".log";
my $logFile = "${logFileDir}/${logFileName}";
my $directoryPrefix="/opt/downloads/latest/today";
my $ua = "Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101\\
Firefox/26.0";
		       
my $cmd = qq{wget -c -N -o "$logFile" -U "$ua" --header="User-Agent:\\
$ua" -P $directoryPrefix --header="Accept: */*" --header="Connection:\\
Keep-Alive" $url};
#print $cmd;
`$cmd`;
`mv /opt/downloads/latest/today/$downloadName /opt/downloads/latest/today/finished/`;


    
