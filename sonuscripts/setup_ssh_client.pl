#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  setup_ssh_client.pl
#
#        USAGE:  ./setup_ssh_client.pl  
#
#  DESCRIPTION:  Automates the setting up of a ssh client on a new linux distro.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Tuesday 05 April 2011 09:05:53  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

# First create the keys.
`ssh-keygen -b 8192 -t rsa`;

