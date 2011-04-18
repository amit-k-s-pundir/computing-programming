#!/usr/bin/perl -w
# router_tool.pl --- A tool to automate some tasks with the home dsl router.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 12 Apr 2011
# Version: 0.01

use warnings;
use strict;

use XML::LibXML;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
#$ua->credentials("admin" => "admin");

my $req = HTTP::Request->new(GET => "http://192.168.1.1/info.html");
$req->authorization_basic("admin", "admin");

my $res = $ua->request($req);
if ($res->is_success) {
    print $res->content;
    
}else {
    print $res->status_line, "\n";
    
}

__END__

=head1 NAME

router_tool.pl - Describe the usage of script briefly

=head1 SYNOPSIS

router_tool.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for router_tool.pl, 

=head1 AUTHOR

Amit K S Pundir, E<lt>sonu@localhostE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Amit K S Pundir

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

None reported... yet.

=cut
