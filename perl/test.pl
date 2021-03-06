#!/usr/bin/perl

use strict;
use warnings;

use feature 'switch';
use feature ":5.10";

use POSIX;

BEGIN{
push @INC, ('/home/sonu/workspace/programming/perl/lib');
#use lib "/home/sonu/workspace/programming/perl/Sonu/Utils/Java/JEE";
#use lib "/home/sonu/workspace/programming/perl/lib/TC";
}
#use Utils;

say "Starting";

my $pid = fork();
if ($pid) {#parent
  $SIG{ALRM} = sub{kill 15, $pid};
#  sleep 25;
  alarm 20;
  # do {
  #   $pid = waitpid(-1;
  # } while ();
 POSIX::pause;
  wait;
}else {# we are in a child
  exec("/usr/bin/gvim");
#  POSIX::pause;
#  wait;
}
# eval {
#     $SIG{ALRM} = sub{kill TERM $$};
#     alarm 10;
#     system("/usr/bin/vim");
# };

say "Exiting";

1;

#Sonu::Vim::Greasemonkey::gen_banner("name", "ns", "desc", "include");
#    gen_banner("name", "ns", "desc", "include");

#    Utils::fix_tc_build_file;
#    create_dir_tree("/home/sonu/workspace/" {a =>
#    &Projects::setup_default_web_component_project;
    
#    my $dir = "/home/sonu/workspace/projects/linux/home/sonu"; 
#    opendir(DH, "$dir") or die("can't open the directory: $!");
#    while(defined(my $file = readdir(DH))){
#        say "Renaming $file:";
#        if($file =~ /^\.(.*)$/){
#            say "New name is: $1";
#            `mv ${dir}/${file} ${dir}/$1`;
#        }
#    }
#    closedir(DH);
#`ls FH`;

