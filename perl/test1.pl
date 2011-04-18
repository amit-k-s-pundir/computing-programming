#!/usr/bin/perl --
   
   	# use strict;
   	# use Frontier::Client;
   	# use Data::Dumper;
   
   	# my $rps = Frontier::Client->new(
   	# 	 url => "http://durgan.daisypark.net/jjohn/rpc_addresses.asp",
   	# 				);
   
   	# print "\nCalling dump_address_book()\n";
   
   	# eval { my $aref = $rps->call("dump_address_book");
   	#        print Dumper($aref);
   	#      };
   
   	# print "\ndone\n";

package Point;
  use Moose;

  has 'x' => (isa => 'Int', is => 'rw', required => 1);
  has 'y' => (isa => 'Int', is => 'rw', required => 1);

  sub clear {
      my $self = shift;
      $self->x(0);
      $self->y(0);
  }

  package Point3D;
  use Moose;

  extends 'Point';

  has 'z' => (isa => 'Int', is => 'rw', required => 1);

  after 'clear' => sub {
      my $self = shift;
      $self->z(0);
  };

  package main;

  # hash or hashrefs are ok for the constructor
  my $point1 = Point->new(x => 5, y => 7);
  my $point2 = Point->new({x => 5, y => 7});

  my $point3d = Point3D->new(x => 5, y => 42, z => -5);
