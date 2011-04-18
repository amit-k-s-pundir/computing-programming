#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  test_lwp.pl
#
#        USAGE:  ./test_lwp.pl  
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
#      CREATED:  Wednesday 03 November 2010 09:59:21  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature ":5.10";

use XML::LibXML;
use LWP;
#use LWP::UserAgent; 

my $browser;
sub do_GET {
  # Parameters: the URL,
  #  and then, optionally, any header lines: (key,value, key,value)
  $browser = LWP::UserAgent->new( ) unless $browser;
  my $resp = $browser->get(@_);
  return ($resp->content, $resp->status_line, $resp->is_success, $resp)
    if wantarray;
  return unless $resp->is_success;
  return $resp->content;
}

sub do_POST {
  # Parameters:
  #  the URL,
  #  an arrayref or hashref for the key/value pairs,
  #  and then, optionally, any header lines: (key,value, key,value)
  $browser = LWP::UserAgent->new( ) unless $browser;
  my $resp = $browser->post(@_);
  return ($resp->content, $resp->status_line, $resp->is_success, $resp)
    if wantarray;
  return unless $resp->is_success;
  return $resp->content;
}
# Create a user agent object.
#my $ua = LWP::UserAgent->new;
#$ua->agent("firefox");
#say $ua->agent;

# Create a request.
#my $req = HTTP::Request->new(POST => 'http://www.google.co.in/');
#$req->content_type('application/x-www-form-urlencoded');
#$req->content('http://forums.topcoder.com/?module=Category&categoryID=8706');


# Pass request to the user agent and get a response back.
#my $res = $ua->request($req);

# Check the outcome of the request.
#if($res->is_success){
#    say $res->content;
#}else{
#    say $res->status_line;
#}

my $res = do_GET 'http://www.reddit.com/r/programming/';

my $fh;
open($fh, '>', "./test_lwp.html");
print $fh "$res";
my $parser = XML::LibXML->new(recover => 1, validation => 0);
#my $dom = XML::LibXML->load_html(string => "$res");
my $dom = $parser->load_html(string => $res);
my $str = $dom->stringtoStringHTML();
print $fh $str;
my $root = $dom->documentElement();
