package test_app2::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

test_app2::View::HTML - TT View for test_app2

=head1 DESCRIPTION

TT View for test_app2.

=head1 SEE ALSO

L<test_app2>

=head1 AUTHOR

Amit K S Pundir,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
