use strict;
use warnings;

use feature ":5.10";
use feature "switch";

my $liferay_home;

sub install_liferay_on_an_existing_as{
  my($liferay_ar) = @_;

  if(&app_listening_at_the_root){
	die "App should not be listening at /!";
  }
