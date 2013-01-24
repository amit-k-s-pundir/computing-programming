#!/usr/bin/perl -w
# start.pl --- Starts the app.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 09 May 2011
# Version: 0.01

use warnings;
use strict;

use CGI::Fast;
use FCGI::ProcManager;

my $proc_manager = FCGI::ProcManager->new({
    n_processes => 10
});

$proc_manager->pm_manage();
while (my $cgi = CGI::Fast->new()) {
    $proc_manager->pm_pre_dispatch();
    # ... handle the request here .....
    $proc_manager->pm_post_dispatch();
    
}

__END__

=head1 NAME

start.pl - Describe the usage of script briefly

=head1 SYNOPSIS

start.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for start.pl, 

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
