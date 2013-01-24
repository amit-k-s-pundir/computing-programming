#!/usr/bin/perl -w
# ft_automation.pl --- Automating the ft.com website for Apache.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 22 Oct 2011
# Version: 0.01

package Apache2Automation::FT;

use warnings;
use strict;

use Apache2::RequestRec ();
use Apache2::RequestIO ();
use CGI::Cookie ();
use APR::Table ();
use Apache2::Const -compile => qw(REDIRECT);

sub handler{
    my $f = shift;
#    my $cookie = CGI::Cookie->new(-name => 'name_here', -value => 'value_here');
    unless ($f->ctx) {
        $f->r->headers_out->set('
    }
}
1;

__END__

=head1 NAME

ft_automation.pl - Describe the usage of script briefly

=head1 SYNOPSIS

ft_automation.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for ft_automation.pl, 

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
