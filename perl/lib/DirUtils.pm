package DirUtils;

use strict; 
use warnings;

use Carp;
use feature ":5.10";

use Cwd;

my @dir_stack = ();

sub pushd{
    my($from_dir, $to_dir) = (cwd, shift);
    push(@dir_stack, $from_dir);
    chdir $to_dir;
}

sub popd{
    my $to_dir = pop @dir_stack;
    chdir $to_dir;
}

1;
__END__

=head1 NAME

DirUtils - Perl extension for blah blah blah

=head1 SYNOPSIS

   use DirUtils;
   blah blah blah

=head1 DESCRIPTION

Stub documentation for DirUtils, 

Blah blah blah.

=head2 EXPORT

None by default.

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

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
