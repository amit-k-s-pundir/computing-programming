#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  setup_php_proj.pl
#
#        USAGE:  ./setup_php_proj.pl  
#
#  DESCRIPTION:  Sets up a new project for php after verifying that the php installation is up to date.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Thursday 23 December 2010 09:49:22  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


my $nginx_dir = "/home/sonu/workspace/programming/web/nginx" unless $nginx_dir;

# It is advisable to keep all the fastcgi settings in one file and importing them (e.g.
# /etc/nginx/fastcgi.conf).  Debian keeps them in /etc/nginx/fastcgi_params by default.
my $fastcgi_config_file = "$nginx_dir" . "/fastcgi_params";

sub verify_with_install_nginx_with_php{
    #&verify_nginx_install && &verify_php_install;
    &install_nginx unless &verify_nginx_install;
    &install_php unless &verify_php_install;
}

sub verify_nginx_install{
    my $which_nginx = `which nginx`;
    if($which_nginx =~ /\/nginx$/){
        die "nginx is not running" unless `pgrep nginx`;
    }else{
        die "looks like nginx is not installed!";
    }
}

sub start_php_fcgi{
    my $bind = 127.0.0.1:9000;
    my $user = "www-data";
    my $php_fcgi_children = 15;
    my $php_fcgi_max_requests = 1000;

    my $php_cgi = "/usr/bin/php-cgi";
    my $php_cgi_name = `basename $php_cgi`;
    my $php_cgi_args= "- USER=$USER PATH=/usr/bin PHP_FCGI_CHILDREN=$PHP_FCGI_CHILDREN
    PHP_FCGI_MAX_REQUESTS=$PHP_FCGI_MAX_REQUESTS $PHP_CGI -b $BIND"
    my $retval = 0;



=begin  BlockComment  # BlockCommentNo_1


#!/bin/bash
BIND=127.0.0.1:9000
USER=www-data
PHP_FCGI_CHILDREN=15
PHP_FCGI_MAX_REQUESTS=1000

PHP_CGI=/usr/bin/php-cgi
PHP_CGI_NAME=`basename $PHP_CGI`
PHP_CGI_ARGS="- USER=$USER PATH=/usr/bin PHP_FCGI_CHILDREN=$PHP_FCGI_CHILDREN PHP_FCGI_MAX_REQUESTS=$PHP_FCGI_MAX_REQUESTS $PHP_CGI -b $BIND"
RETVAL=0

start() {
      echo -n "Starting PHP FastCGI: "
      start-stop-daemon --quiet --start --background --chuid "$USER" --exec /usr/bin/env -- $PHP_CGI_ARGS
      RETVAL=$?
      echo "$PHP_CGI_NAME."
}
stop() {
      echo -n "Stopping PHP FastCGI: "
      killall -q -w -u $USER $PHP_CGI
      RETVAL=$?
      echo "$PHP_CGI_NAME."
}

case "$1" in
    start)
      start
  ;;
    stop)
      stop
  ;;
    restart)
      stop
      start
  ;;
    *)
      echo "Usage: php-fastcgi {start|stop|restart}"
      exit 1
  ;;
esac
exit $RETVAL


=end    BlockComment  # BlockCommentNo_1

=cut

