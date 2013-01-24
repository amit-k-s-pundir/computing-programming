# A very simple obfuscation filter -- turn an HTML document into a one liner, which will
# make it harder to read its source without a special processing. To accomplish
# that we are going to remove characters \012 (\n) and \015 (\r), which depending
# on the platform alone or as a combination represent the end of line and a
# carriage return.


#file:MyApache2/FilterObfuscate.pm
#--------------------------------
package Apache::ConnectionFilterObfuscate;
  
use strict;
use warnings;

use base qw(Apache2::Filter);

use Apache2::Filter ();
use Apache2::RequestRec ();
use APR::Table ();
  
use Apache2::Const -compile => qw(OK);
  
use constant BUFF_LEN => 1024;

sub output : FilterConnectionHandler {
      my ($f, $bb, $mode, $block, $readbytes) = @_;
  
      unless ($f->ctx) {
          $f->r->headers_out->unset('Content-Length');
          $f->ctx(1);
      }
  
      while ($f->read(my $buffer, BUFF_LEN)) {
          $buffer =~ s/[\r\n]//g;
          $f->print($buffer);
      }
  
      return Apache2::Const::OK;
  }
  1;

__END__

=head1 NAME

FilterObfuscate - Perl extension for blah blah blah

=head1 SYNOPSIS

   use FilterObfuscate;
   blah blah blah

=head1 DESCRIPTION

Stub documentation for FilterObfuscate, 

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
