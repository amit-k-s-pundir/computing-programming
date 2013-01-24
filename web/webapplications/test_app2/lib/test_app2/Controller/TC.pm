package test_app2::Controller::TC;
use Moose;
use namespace::autoclean;

use LWP;
use LWP::UserAgent;

use TC::Utils;


BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

test_app2::Controller::TC - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 activeContests

=cut

sub activeContest :Local{

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched test_app2::Controller::TC in TC.');
}

=head2 get_assembly_contests

Fetches the currently active assembly contests from TC site.

=cut

sub get_show_assembly_contests :Local{
my ($self, $c) = @_;

my @active_assembly_contests = get_active_assembly_contests();
disp
$c->stash(username => 'amit_pundir',
template => 'tc/test.tt');
}

my $content_file = "temp.html";


=head2 get_active_assembly_contests

=cut

sub get_active_assembly_contests{
    my $url = shift;
    
    my $req = HTTP::Request->new(GET => $url);
    my $res = $ua->request($req, "$content_file");
    if ($res->is_success) {
        say $res->content;
    }
}

sub parse_assembly_contests{
    my $doc = XML::LibXML->new->parse_file($content_file);
    my $xc = XML::LibXML::XPathContext->new($doc);
    my $root_xpath = "/html/body/table/tbody/tr/td[2]/table[3]";
    my @nodes = $xc->findnodes($root_xpath);
}



=head1 AUTHOR

Amit K S Pundir,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
