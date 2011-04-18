#!/usr/bin/perl

my $r = Apache->request;
$r->send_http_header("text/plain");
$r->print("mod_perl rules!\n");

#print "Content-type: text/plain\n\n";
#print "mod_perl 2.0 rocks!\n";
