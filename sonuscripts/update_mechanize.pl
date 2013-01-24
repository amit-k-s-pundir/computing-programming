#!/usr/bin/perl -w
# update_mechanize.pl --- Just testing WWW::Mechanize module.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 21 Mar 2011
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";
use WWW::Mechanize;
use WWW::Mechanize::Link;

my $mech= WWW::Mechanize->new(autocheck => 1);
$mech->get("http://search.cpan.org/dist/WWW-Mechanize/");
my $link = $mech->find_link(url_regex => qr/WWW-Mechanize-1.66.tar.gz$/i);
#chop(my $base = $link->base());
#say $base;
#my $target = $base . $link->url();
$mech->get(my $target = $link->url_abs(), ":content_file" => "test.tar.gz");

#`wget -c -N $target`;

#$mech->follow_link(url_regex => qr/WWW-Mechanize-1.66.tar.gz$/i);

1;


__END__

=head1 NAME

TestMechanize.pl - Describe the usage of script briefly

=head1 SYNOPSIS

TestMechanize.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for TestMechanize.pl, 

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
