#!/usr/bin/perl

#package Sonu::Automation;

use strict;
use feature ":5.10";

main(@ARGV);

sub main{
    my($downloadDir) = @_;
#    say $downloadDir;
    finish_downloads($downloadDir);
}

sub finish_downloads{
    my($downloadDir) = @_;
    opendir(my $dh, $downloadDir);
    for my $file (map {"$downloadDir" . $_}(readdir $dh)){
	if(actual_size($file) < supposed_size($file)){
	    finish_download($file);
	}
    }
    closedir($dh);
}

sub actual_size{
    my $file = shift;
    return(-s $file);
}

sub supposed_size{
    my $file = shift;
    my $logfile = logfile_for_file($file);
    my $lengthStringPattern = 'Length: (\d+) \((\d+M)\)\\
    \[video/x-flv\]';
    open(my $ifh, $logfile);
    while(<$ifh>){
	if(/$lengthStringPattern/){
	    return $1;
	}
    }
}

sub logfile_for_file{
    my($file) = @_;
    return("wget-log-" . $file . ".log");
}

sub finish_download{
    my($file) = @_;
    my $logFile = logfile_for_file($file);
    my $urlLinePattern = '--.*--\s+(http://.*\.flv)';
    open(my $ifh, $logFile);
    my($directoryPrefix, $ua)
	= ("/opt/downloads/latest/today",
	   "Mozilla/5.0 (X11; Linux i686; rv:26.0) Gecko/20100101\\
    Firefox/26.0");
    my $url;
    while(<$ifh>){
	if(/$urlLinePattern/){
	    $url = $1;
	}
    }
    
    my $cmd = qq{wget -c -N -o "$logFile" -U "$ua" --header="User-Agent:\\
$ua" -P $directoryPrefix --header="Accept: */*" --header="Connection:\\
Keep-Alive" --header="Referer: $referer" $url};
    `$cmd`;
}
    
