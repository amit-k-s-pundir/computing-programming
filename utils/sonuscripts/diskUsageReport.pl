#!/usr/bin/perl -w
# diskUsageReport.pl --- Reports about disk usage of the system and points
# out anything abnormal.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 07 Apr 2012
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";
use Log::Log4Perl;

Log::Log4Perl->init("log.conf");

my @default_dirs_to_watch = (qw(/opt/apache2/logs /opt/.dwhelper));
my $log_file = "diskUsageLog.txt";

sub cleanApacheLogs{
    my($errorLog, $accessLog) = @_;
    $errorLog = "${apacheLogDir}/error_log" unless $errorLog;
    $accessLog = "${apacheLogDir}/access_log" unless $accessLog;

    my $cmd = "rm -f ";
    `$cmd . $errorLog . $accessLog`;
}


monitorDiskUsage($dirsToWatch);

sub monitorDiskUsage{
    my $dirsToWatch = shift;
    for my $dir (@$dirsToWatch) {
        watchDirForDiskUsage($dir);
        
    }
}

sub watchDirForDiskUsage{
    my ($dirToWatch, $limit, $action) = @_;
    my $dirSize = `du -sh $dirToWatch`;
    if ($dirSize => $limit) {
        $action->($dirToWatch);
    }
    
}
    
        


__END__

=head1 NAME

diskUsageReport.pl - Describe the usage of script briefly

=head1 SYNOPSIS

diskUsageReport.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for diskUsageReport.pl, 

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
