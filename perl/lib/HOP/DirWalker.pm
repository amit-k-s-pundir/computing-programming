sub dir_walk{
  my($top, $filefunc, $dirfunc) = @_;
  my $DIR;

  if(-d $top){
    my $file;
    unless(opendir $DIR, $top){
      warn "Couldn't open directory $code: $!; skipping. \n";
      return;
    }

    my @results;
    while($file = readdir $DIR){
      next if $file eq '.' || $file eq '..';
      push @results, dir_walk("$top/$file", $filefunc, $dirfunc);
    }
    return $dirfunc->($top, @results);
  }else{
    return $filefunc->($top);
  }
}

# To compute the total size of the current directory, we will use
# dir_walk() like this:
# sub file_size{
#   -s $_[0];
# }

# sub dir_size{
#   my $dir = shift;
#   my $total = -s $dir;
#   my $n;
#   for $n (@_){
#     $total += $n;
#   }
#   return $total;
# }

# $total_size = dir_walk('.', \&file_size, \&file_size, \&dir_size);
