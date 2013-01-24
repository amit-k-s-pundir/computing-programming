  #file:Apache/Dump.pm
  #---------------------
  package Apache::Dump;
  
  use strict;
  use warnings;
  
  use Apache2::RequestRec ();
  use Apache2::RequestIO ();
  use Apache2::Filter ();
  use APR::Brigade ();
  use APR::Bucket ();
  
  use Apache2::Const -compile => qw(OK M_POST);
  
  sub handler {
      my $r = shift;
      $r->content_type('text/plain');
  
      $r->print("args:\n", $r->args, "\n");
  
      if ($r->method_number == Apache2::Const::M_POST) {
          my $data = content($r);
          $r->print("content:\n$data\n");
      }
  
      return Apache2::Const::OK;
  }
  
  use Apache2::Connection ();
  
  use Apache2::Const -compile => qw(MODE_READBYTES);
  use APR::Const     -compile => qw(SUCCESS BLOCK_READ);
  
  use constant IOBUFSIZE => 8192;
  
  sub content {
      my $r = shift;
  
      my $bb = APR::Brigade->new($r->pool, $r->connection->bucket_alloc);
  
      my $data = '';
      my $seen_eos = 0;
      do {
          $r->input_filters->get_brigade($bb, Apache2::Const::MODE_READBYTES,
                                         APR::Const::BLOCK_READ, IOBUFSIZE);
  
          for (my $b = $bb->first; $b; $b = $bb->next($b)) {
              if ($b->is_eos) {
                  $seen_eos++;
                  last;
              }
  
              if ($b->read(my $buf)) {
                  $data .= $buf;
              }
  
              $b->remove; # optimization to reuse memory
          }
      } while (!$seen_eos);
  
      $bb->destroy;
  
      return $data;
  }
  
 1;


__END__

=head1 NAME

Dump - Perl extension for blah blah blah

=head1 SYNOPSIS

   use Dump;
   blah blah blah

=head1 DESCRIPTION

Stub documentation for Dump, 

Blah blah blah.

=head2 EXPORT

None by default.

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

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
