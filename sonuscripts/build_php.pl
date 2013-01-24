#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  t.pl
#
#        USAGE:  ./t.pl  
#
#  DESCRIPTION:  A Perl scratch pad for throw-away programs.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Friday 24 December 2010 09:47:54  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use feature ":5.10";
use feature "switch";
use Cwd;

my $orig_dir = getcwd;
my $work_dir = "/home/sonu/programming/php/php_src"

chdir $work_dir;
#opendir(my $dh, $work_dir) or die "Can't opendir $work_dir: $!";
#my $php_src_dirs = grep {/.*

my $php_config_options = "--enable-fpm --with-openssl=/usr --with-pcre-regex --with-zlib=/usr
--enable-calendar --with-curl=/usr --enable-ftp --with-ldap --with-unixODBC=/usr --with-pgsql=/usr
--with-readline --enable-sockets --enable-soap --enable-sqlite-utf8 --enable-zip";

my $script="./configure $php_config_options && make && sudo make install";

`$script`;

`sudo cp $work_dir/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && sudo chmod 755 /etc/init.d/php-fpm`

chdir $orig_dir;

1;
