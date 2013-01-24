#!/usr/bin/perl

use strict;
use warnings;

use feature ":5.10";

use LWP;
use LWP::UserAgent;
use XML::LibXML;

my $ua = LWP::UserAgent->new;

my $content_file = "temp.html";

get_active_assembly_contests("http://www.topcoder.com/tc?module=ViewAssemblyActiveContests");
parse_assembly_contests();


=head2 get_active_assembly_contests

=cut

sub get_active_assembly_contests{
    my $url = shift;
    
    my $req = HTTP::Request->new(GET => $url);
    my $res = $ua->request($req, $content_file);
    if ($res->is_success) {
        say $res->content;
    }
}

sub parse_assembly_contests{
    # This is old style loading/parsing interface.
    #    my $doc = XML::LibXML->new->parse_file($content_file);
    my $doc = XML::LibXML->load_html(location => $content_file, recover => 2, suppress_errors => 1);
    my $xc = XML::LibXML::XPathContext->new($doc);
    my $root_xpath = "/html/body/table/tbody/tr/td[2]/table[3]";
    my @nodes = $xc->findnodes($root_xpath);
    my $length = scalar(@nodes);
    say $length;
    foreach my $node (@nodes ) {
        say $node->to_literal();
    }
}



=head1 AUTHOR

Amit K S Pundir,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut



1;
