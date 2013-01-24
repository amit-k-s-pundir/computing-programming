#!/usr/bin/perl -w
# t.pl --- Test File.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 04 Apr 2012
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";

my $arr_ref = [qw(sonu pundir)];
say($arr_ref->[0]);

my $word = "";
$word .= "pundir";
say $word;


# sub generator{
#     my($arg1, $arg2) = (shift, shift);
#     eval("sub ${arg1}{
#         say \"$arg2\";
#     }"
#      );
# }

# generator("testRoutine", "hello!");
# testRoutine();

1;

    

__END__

=head1 NAME

t.pl - Describe the usage of script briefly

=head1 SYNOPSIS

t.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for t.pl, 

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
