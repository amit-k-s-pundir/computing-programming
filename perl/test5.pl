#!/usr/bin/perl -w
# test5.pl --- Testing eval.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 14 Jul 2011
# Version: 0.01

use warnings;
use strict;

sub def_shell_cmd{
my ($cmd, $cmd_str) = @_;
my $str = "sub ${cmd} { `${cmd_str}`};";
eval(${str});
};

def_shell_cmd("gvim", "gvim");
gvim();
1;


__END__

=head1 NAME

test5.pl - Describe the usage of script briefly

=head1 SYNOPSIS

test5.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for test5.pl, 

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
