#!/usr/bin/perl -w
# update_pde.pl --- Updates the PDE mode for Perl in Emacs.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 23 Mar 2011
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";
use Cwd;
use WWW::Mechanize;
use WWW::Mechanize::Link;

my $work_dir = "/home/sonu/.emacs.d";
my $orig_dir = getcwd();

chdir $work_dir;

my $mech = WWW::Mechanize->new(autocheck => 1);
$mech->get("http://search.cpan.org/dist/Emacs-PDE/");
my $link = $mech->find_link(n => 1, text_regex => qr/Download/);
#say "hello";
my $url = $link->url_abs();
say $url;
`wget -N -c $url`;
#chdir "~/.emacs.d/";
unless (-e "./t" && -d "./t") {
    mkdir "./t/" or die "Couldn't create the temp directory t: $!";
}
chdir "./t";
`mv "${work_dir}"/Emacs-PDE-*tar.gz ./`;
opendir(my $fh, getcwd());
my @files = readdir($fh);
my @matches = grep {/^Emacs.*tar\.gz$/} @files;
if (scalar(@matches) != 1) {
    die "There can be only one PDE downloaded file to be untared!";
}
my $tar_file = $matches[0];
`tar zxvf "$tar_file"`;
$tar_file =~ /(^Emacs-PDE-.*)(\.tar\.gz$)/;
my $final_dir = $1;
#say $final_dir;
`mv "$final_dir" ../ && mv "$tar_file" ../downloads`;

chdir $orig_dir;

1;


__END__

=head1 NAME

update_pde.pl - Describe the usage of script briefly

=head1 SYNOPSIS

update_pde.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for update_pde.pl, 

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
