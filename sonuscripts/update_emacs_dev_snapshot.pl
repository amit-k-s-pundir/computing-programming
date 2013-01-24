#!/usr/bin/perl -w
# update_emacs_dev_snapshot.pl --- Updates the dev snapshot of emacs from the repo mirror at github.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 29 Jan 2012
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";

my $url = "https://github.com/emacsmirror/emacs/tarball/master";
my $cmd = "wget -N -c $url";


__END__

=head1 NAME

update_emacs_dev_snapshot.pl - Describe the usage of script briefly

=head1 SYNOPSIS

update_emacs_dev_snapshot.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for update_emacs_dev_snapshot.pl, 

=head1 AUTHOR

Amit K S Pundir, E<lt>sonu@localhostE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by Amit K S Pundir

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

None reported... yet.

=cut
