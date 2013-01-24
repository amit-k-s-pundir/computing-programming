use feature ":5.10";

my @x = ("what", "is", "your", "name", "?");

sub f{
  my (@arg) = @_;
  say join(" ", @arg);
}

f(@x);

1;
