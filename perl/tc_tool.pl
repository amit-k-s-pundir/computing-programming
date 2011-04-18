#!/usr/bin/perl -w
# tc_tool.pl --- A tool to automate some interaction with the Topcoder.com site.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 05 Apr 2011
# Version: 0.01

use warnings;
use strict;

get_and_show_contests;

sub get_and_show_contests{
    show_contests(get_default_contests);
};

sub get_default_contests{
    my $url = "test.html";
    get_assembly_contests;
    
}

sub get_assembly_contests{
    my $url = "http://www.topcoder.com/tc?module=ViewAssemblyActiveContests";
    my $ua = LWP::UserAgent->new;
    $ua->agent("$0/0.1 " . $ua->agent);
    my $req = HTTP::Request->new(GET => $url);
    $req->header(Accept => text/html);
    my $es = $ua->request($req);
    if ($res->is_success) {
        say $res->decoded_content;
        
    }
    else {
        say("Error: " .$res->status_line);
        
    }
}

sub show_contests{
    my %contests = shift;
    draw_table(\%contests);
};

sub draw_table{
    my ($fn, $table_data) = @_;

    if (defined($fn)) {
        &$fn($table_data);
    }else {
        draw_table_ncurses($table_data);
        
    }
}

sub draw_table_ncurses{
    my $table_data = shift;
}


__END__

=head1 NAME

tc_tool.pl - Describe the usage of script briefly

=head1 SYNOPSIS

tc_tool.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for tc_tool.pl, 

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
