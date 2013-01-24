#!/usr/bin/perl

use feature ":5.10";

f1();

sub f1{
  f2();
}

sub f2{
  say "In f2";
}

