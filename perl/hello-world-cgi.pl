#!/usr/bin/perl

use CGI qw(:standard);
my $username = param('username')||"sonu";

print "Content-type: text/plain\n\n";
print "Hello, $username!\n";
