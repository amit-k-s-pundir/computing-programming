#!/usr/bin/perl -w
# install_mozrepl.pl --- Installs mozrepl for firefox.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 03 Jul 2011
# Version: 0.01

use warnings;
use strict;

sub firefox_mozrepl_plugin_installed_p{
    1;
};
    
firefox_mozrepl_plugin_installed_p or die "Firefox plugin mozrepl is not
installed: $!";
my $mozrepl_repo = "git://github.com/bard/mozrepl.git";
my $base_dir =
    "/home/sonu/workspace/programming/sources/mozrepl/mozrepl/chrome/content";
my $espresso_file = $base_dir . "espresso.el";
my $moz_file = $base_dir . "moz.el";
my $emacs_site_lisp_dir = "/home/sonu/.emacs.d/site-lisp";
my $install_dir = $emacs_site_lisp_dir . "/mozrepl";
mkdir($install_dir) unless $install_dir;
with_dir($dir, $lambda);

chdir $install_dir;
for my $source_file (@source_files) {
    rsync($source_file, $source_file);
}
__END__

=head1 NAME

install_mozrepl.pl - Describe the usage of script briefly

=head1 SYNOPSIS

install_mozrepl.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for install_mozrepl.pl, 

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
