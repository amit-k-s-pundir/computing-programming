#!/usr/bin/perl -w
# build_llvm.pl --- Automates building of the llvm source.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 02 Mar 2012
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";
use DirUtils;

my $SRC_ROOT = "/home/sonu/workspace/programming/sources/llvm";
my $OBJ_ROOT = "${SRC_ROOT}/build";

DirUtils::pushd($SRC_ROOT);

#with_dir($SRC_ROOT, sub{
 #            mkdir("${SRC_ROOT}/build")});
 
mkdir("${SRC_ROOT}/build") unless -d -f ${OBJ_ROOT} ;
DirUtils::pushd $OBJ_ROOT;
my $configure_options = "--prefix=/opt/llvm --enable-debug-runtime \\
--enable-debug-symbols --enable-doxygen --enable-libffi";
my $cmd = "${SRC_ROOT}/configure ${configure_options}";
`$cmd`;

DirUtils::popd();
&DirUtils::popd;

1;

__END__

=head1 NAME

build_llvm.pl - Describe the usage of script briefly

=head1 SYNOPSIS

build_llvm.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for build_llvm.pl, 

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
