#!/usr/bin/perl
#use strict;
use feature "say";
use feature "switch";

#package utils;
use Getopt::Std;

&main(@ARGV);

sub main{
  &dispatch(@_);
#  download(undef, undef, "www.google.com");
}

sub dispatch{
  my $verb = shift;
  &$verb(@_);
}

#usage: download [-d downloadProgram] [-w wd] listOfURLS
#download $wd $downloader @urls
# sub download{
#   my $wd = shift;
#   my $downloader = shift;
#   my @urls;
#   $wd = "/opt/downloads" unless $wd;
#   $downloader = "wget -NcpP${wd}" unless $downloader;
#   my @urls = @_;
#   my $url;
#   for $url (@urls){
# 	print "${url}\n";
# 	my $cmd = "${downloader} ${url}";
# 	print ${cmd}, "\n";
# 	`${cmd}`;
# 	}
	
#  my $downloader;
  #  my $wd = "/opt/downloads";
  # if($@_[0] == "-d"){
  # 	shift;
  # 	$downloader = $@_[1];
  # 	shift;
  # }elseif($@_[0] =~ /^-d(.+)$/){
  # 	shift;
  # 	$downloader = $1;
  # }
#}
 
sub usage{
  say "download urls [command used for downloading]";
}

sub decompress{
  my $verb = shift;

  given($verb){
	when ("untar" == $verb){
	  &decompress_tar (@_);
	}
  }
}

sub decompress_tar {
  print `tar zxvf "@_"`;
}

sub pushd_do{
    my ($work_dir, $fn_ref, $args_ref) = @_;
    my $orig_dir = getcwd;
    chdir $work_dir;
    &$fn_ref(@$args_ref);
    chdir $orig_dir;
}

# Example of the Perl 6 "switch" feature
 # given($_) {
 # 	when (/^abc/) { $abc = 1; }
 # 	when (/^def/) { $def = 1; }
 # 	when (/^xyz/) { $xyz = 1; }
 # 	default { $nothing = 1; }
 #    }
