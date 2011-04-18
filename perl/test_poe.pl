#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  test_poe.pl
#
#        USAGE:  ./test_poe.pl  
#
#  DESCRIPTION:  Testing and playing with some POE stuff.
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  Thursday 04 November 2010 01:50:12  IST
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use POE;

POE::Session->create(
  inline_states => {
    _start => \&session_start,
    _stop  => \&session_stop,
    count  => \&session_count,
  }
);
print "Starting POE::Kernel.\n";
POE::Kernel->run();
print "POE::Kernel's run() method returned.\n";
exit;

sub session_start {
  print "Session ", $_[SESSION]->ID, " has started.\n";
  $_[HEAP]->{count} = 0;
  $_[KERNEL]->yield("count");
}

sub session_stop {
  print "Session ", $_[SESSION]->ID, " has stopped.\n";
}

sub session_count {
  my ($kernel, $heap) = @_[KERNEL, HEAP];
  my $session_id = $_[SESSION]->ID;
  my $count      = ++$heap->{count};
  print "Session $session_id has counted to $count.\n";
  $kernel->yield("count") if $count < 10;
}

