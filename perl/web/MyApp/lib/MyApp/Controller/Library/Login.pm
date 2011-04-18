package MyApp::Controller::Library::Login;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

MyApp::Controller::Library::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched MyApp::Controller::Library::Login in Library::Login.');
}


=head1 AUTHOR

Amit Pundir,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;