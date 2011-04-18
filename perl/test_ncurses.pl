#!/usr/bin/perl -w
# test_ncurses.pl --- Testing Curses::UI module.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 04 Apr 2011
# Version: 0.01

use warnings;
use strict;

use Curses::UI;

my $cui = new Curses::UI(-color_support => 1);

my @menu = (
    { -label => 'File',
      -submenu => [
          { -label => 'Exit    ^Q', -value => \&exit_dialog}
              ]
          },
);

sub exit_dialog(){
    my $return = $cui->dialog(
        -message => "Do you really want to quit?",
        -title => "Are you sure??",
        -buttons => ['yes', 'no'],
    );

    exit(0) if $return;
};

my $menu = $cui->add(
    'menu', 'Menubar',
    -menu => \@menu,
    -fg => "blue",
);

my $win1 = $cui->add(
    'win1', 'Window',
    -border => 1,
    -y => 1,
    -bfg => 'red',
);

my $texteditor = $win1->add("text", "TextEditor",
                            -text => "Here is some text\n"
                                . "And some more");

$cui->set_binding(sub {$menu->focus()}, "\cX");
$cui->set_binding( \&exit_dialog, "\cQ");

$texteditor->focus();
$cui->mainloop;


__END__

=head1 NAME

test_ncurses.pl - Describe the usage of script briefly

=head1 SYNOPSIS

test_ncurses.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for test_ncurses.pl, 

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
