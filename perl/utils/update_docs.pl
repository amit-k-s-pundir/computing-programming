#!/usr/bin/perl -w
# update_docs.pl --- Updates all the docs on system.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 10 Mar 2012
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";

my @doc_update_scripts = map {"update_docs" . "_$_"} ("perl", "lisp", "java", "candcplusplus",
                          "linux_programming", "linux_general");

for my $script (@doc_update_scripts){
    #system($script);
    say $script;
}


__END__

=head1 NAME

update_docs.pl - Describe the usage of script briefly

=head1 SYNOPSIS

update_docs.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for update_docs.pl, 

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
