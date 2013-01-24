 #file:FilterObfuscate.pm
 #--------------------------------
 package MyApache2::FilterObfuscate;
 use strict;
 use warnings;

 use Apache2::Filter ();
 use Apache2::RequestRec ();
 use APR::Table ();
 use Apache2::Const -compile => qw(OK);
 use constant BUFF_LEN => 1024;

 sub handler {
      my $f = shift;

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
