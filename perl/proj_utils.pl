#!/usr/bin/perl -w

use strict;
use File::Copy;

&main;

sub main{
 &setup_proj(\&setup_project_fn, ['test_tc_des_proj', '/home/sonu/workspace/projects/tc/design',
		 '/opt/downloads', ['test.jar']]);
};

sub setup_proj{
my($setup_project_fn, $args) = @_;
&$setup_project_fn (@$args);
};

sub setup_project_fn{
my($proj_name, $base_dir, $download_dir, $downloads)
  = @_;
$base_dir = '/home/sonu/workspace/projects/tc/design' unless $base_dir;
$download_dir = '/opt/downloads' unless $download_dir;
$downloads = [$proj_name . '.jar', $proj_name . '.zip'] unless $downloads;
my $proj_dir = "$base_dir/$proj_name";
#mkdir $proj_dir;# unless [-d $proj_dir];
chdir $proj_dir or die "Can't cd to $proj_dir: $!\n";

for my $download_item (@$downloads){
  for my $glob_item (glob $download_item){
	print("\$downlad_dir = $download_dir, \$glob_item =
$glob_item, \$proj_dir = $proj_dir \n");
	copy($download_dir . "/" . $glob_item, "$proj_dir");
  }
}
}

sub setup_web_proj_fn{
 $dir_tree_href = {"lib", "controller", "ext_lib", "view", "kernel", "model", "resources"}; 
     return 1;
 }
