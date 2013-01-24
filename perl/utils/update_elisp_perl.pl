#!/usr/bin/perl -w
# update_elisp_perl.pl --- Downloades and updates elisp files/libs for useful for
# working with Perl.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 25 Jul 2011
# Version: 0.01

use warnings;
use strict;

use WWW::Mechanize::Firefox;

my $mech = WWW::Mechanize::Firefox->new();
#$mech->get('http://google.com/');
$mech->get('http://news.ycombinator.com/');
$mech->follow_link(text_regex => qr/login/i);

$mech->eval_in_page('alert("Hello Firefox")');


__END__

=head1 NAME

update_elisp_perl.pl - Describe the usage of script briefly

=head1 SYNOPSIS

update_elisp_perl.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for update_elisp_perl.pl, 

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
