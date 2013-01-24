#!/usr/bin/perl -w
# test.pl --- 
# Author: Amit K S Pundir <sonu@localhost>
# Created: 07 Apr 2012
# Version: 0.01

use warnings;
use strict;

use feature ":5.10";

my @config_options = qw(--with-included-apr --prefix=/opt/apache2
--enable-maintainer-mode --enable-modules=all  --enable-mods-shared=all
--enable-authn-alias --enable-authn-anon --enable-authn-dbd --enable-authn-alias
--enable-authz-owner --enable-authnz-ldap --enable-auth-digest
--enable-file-cache --enable-cache --enable-disk-cache --enable-mem-cache
--enable-dbd --enable-bucketeer --enable-dumpio --enable-echo --enable-example
--enable-case-filter --enable-case-filter-in --enable-reqtimeout
--enable-ext-filter --enable-substitute --enable-charset-lite --enable-deflate
--enable-ldap --enable-log-forensic --enable-logio --enable-mime-magic
--enable-cern-meta --enable-expires --enable-headers --enable-ident
--enable-usertrack --enable-unique-id --enable-proxy --enable-proxy-connect
--enable-proxy-ftp --enable-proxy-http --enable-proxy-scgi --enable-proxy-ajp
--enable-proxy-balancer --enable-ssl --enable-optional-hook-export
--enable-optional-hook-import --enable-optional-fn-export
--enable-optional-fn-import --enable-http --enable-dav --enable-info
--enable-suexec --enable-cgi --enable-cgid --enable-dav-fs
--enable-dav-lock --enable-vhost-alias --enable-imagemap
--enable-speling --enable-rewrite --enable-so);

say join(" ", @config_options);

1;

# while (<STDIN>) {
#     say $;
# }


__END__

=head1 NAME

test.pl - Describe the usage of script briefly

=head1 SYNOPSIS

test.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for test.pl, 

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
