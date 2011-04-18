#!/usr/bin/perl
#===============================================================================
#
#         FILE:  HelloWorld.pm
#
#  DESCRIPTION: The first 'HelloWorld' Apache module.
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Monday 10 May 2010 08:58:15  IST
#     REVISION:  ---
#===============================================================================
package Apache::HelloWorld;

use strict;
use warnings;


#package Apache::HelloWorld;
# File: apache/HelloWorld.pm

sub handler{
    my $r = shift;
    $r->content_type('text/html');
#    $r->send_http_header;
    my $host = "sonu"; # $r->get_remote_host;
    $r->print(<<END);
    <HTML>
    <HEAD>
<TITLE>Hello There</TITLE>
</HEAD>
<BODY>
<H1>Hello $host</H1>
Who would take this book seriously if the first example didn't
say "hello world"?
</BODY>
</HTML>
END
    return 0;
}
1;
