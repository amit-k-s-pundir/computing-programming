#!/usr/bin/perl

use CGI::Fast qw(:standard);
$COUNTER = 0;
while (new CGI::Fast) {
    print header;
    print start_html("Fast CGI Rocks");
    print
		h1("Fast CGI Rocks"),
		"Invocation number ",b($COUNTER++),
		" PID ",b($$),".",
		hr;
	print end_html;
}
