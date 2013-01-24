#!/usr/bin/perl -w
# build_apache_httpd.pl --- Automates the building of Apache webserver for both stable
# and dev versions.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 03 Nov 2011
# Version: 0.01

use warnings;
use strict;

use feature "switch";
use feature ":5.10";

my($ap_dev_work_dir, $ap_stable_work_dir) = (shift, shift);

my @config_options = qw(--with-included-apr --prefix=/opt/apache2 
--enable-maintainer-mode --enable-modules=all
--enable-mods-shared=all --enable-load-all-modules
--enable-authn-anon --enable-authn-dbd --enable-authn-socache
--enable-authz-owner --enable-authz-dbd --enable-auth-form
--enable-auth-digest  --enable-apreq --enable-file-cache
--enable-cache --enable-cache-disk --enable-watchdog
--enable-dbd --enable-bucketeer --enable-dumpio --enable-echo
--enable-example --enable-case-filter --enable-case-filter-in
--enable-example-ipc --enable-buffer --enable-data --enable-ratelimit
--enable-ext-filter --enable-request --enable-include
--enable-substitute --enable-charset-lite --enable-deflate
--enable-xml2enc --enable-proxy-html --enable-http --enable-log-debug
--enable-log-forensic --enable-logio --enable-mime-magic
--enable-expires --enable-headers --enable-ident --enable-usertrack
--enable-unique-id --enable-proxy --enable-proxy-connect
--enable-proxy-ftp --enable-proxy-http --enable-proxy-fcgi
--enable-proxy-scgi --enable-proxy-fdpass --enable-proxy-ajp
--enable-proxy-balancer --enable-session --enable-session-cookie
--enable-session-dbd --enable-ssl
--enable-optional-hook-export --enable-optional-hook-import
--enable-optional-fn-export --enable-optional-fn-import --enable-dav
--enable-info --enable-suexec --enable-cgi --enable-cgid --enable-dav-fs
--enable-dav-lock --enable-vhost-alias --enable-imagemap
--enable-actions --enable-speling --enable-userdir --enable-rewrite
--enable-so);

my $config_options_str = join(" ", @config_options);
#my $debug_single_threaded_prefork_config_options = $config_options
#  . "--enable-mpms-shared=all";

my $config_cmd = "./configure $config_options_str";
my $build_cmd = 'make';
my $install_cmd = 'make install';
my $cmd = "$config_cmd && $build_cmd &&
  $install_cmd";
#say $cmd;
#my $stdoutput = `$cmd`;
#say $output;

sub with_dir_shell_cmd{
    my ($work_dir, $cmd) = @_;
#    my $orig_dir = cwd;
    `pushd ${work_dir} && $cmd && popd`;
  }

with_dir_shell_cmd("/opt/sources/apache/httpd-trunk", $cmd);

1;


__END__

=head1 NAME

build_apache_httpd.pl - Describe the usage of script briefly

=head1 SYNOPSIS

build_apache_httpd.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for build_apache_httpd.pl, 

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
