#!/usr/bin/perl -w

use warnings;
use strict;

use feature ":5.10";
use Cwd;

my $orig_dir = getcwd();
#my $work_dir = "/opt/lisp/cl/sources/sbcl";
#my $work_dir = "~/workspace/programming/sources/lisp/cl/sbcl";
my $work_dir = "/opt/sources/lisp/cl/sbcl";
my $install_dir = "/opt/sbcl-dev";
my $update_cmd = "git pull";
my $build_cmd = "sh make.sh --fancy --prefix=${install_dir}";
my $build_doc_cmd = "pushd doc/manual && make && popd";
my $install_cmd = "sh install.sh";
my $cmd = $update_cmd . " && " . $build_cmd . " && " . $build_doc_cmd
    . " && " . $install_cmd;

chdir($work_dir);
#print $cmd;
`$cmd`;

#`cvs update`;

chdir($orig_dir);

1;




