#!/usr/bin/perl -w
# Util.pl --- Utilities functions.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 23 Oct 2011
# Version: 0.01

use warnings;
use strict;

sub sanitize_js{
    my $in_string = shift;
    my $out_string = s/$js_pattern/$in_string/s;
    
}

Host: www.ft.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-us,en;q=0.5
Accept-Encoding: gzip, deflate
Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
DNT: 1
Connection: keep-alive
Host: www.ft.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-us,en;q=0.5
Accept-Encoding: gzip, deflate
Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
DNT: 1
Connection: keep-alive
Referer: http://www.google.co.in/url?sa=t&rct=j&q=indian%20funds%20aim%20to%20weather%20the%20crisis&source=web&cd=1&ved=0CB8QqQIwAA&url=http%3A%2F%2Fwww.ft.com%2Fcms%2Fs%2F47bf7cf6-f4ea-11e0-824e-00144feab49a.html&ei=NpqjTpruI4vPrQf0vY3yAg&usg=AFQjCNE7oVWU_4ab-6YwTA-HvIk_SMm9Mg&cad=rja
Cookie: opPageCount=113x1311457328620%26sub%3D1; opFTData=%26v%3D1; FTUserTrack=117.212.66.187.1311457327881589; AYSC=_04karnataka_13IND_14IND_15in_17PVT_18bangalore_24asia_25PVT_26PVT_27PVT_96PVT_98PVT_; GZIP=1; FT_M=D=D,F=,R=0; rsi_segs=J07717_11049|J07717_10702|J07717_10555|J07717_10301|J07717_10982|J07717_11009|J07717_11148|J07717_11189; op553indiahomepageoverlaygum=a03f0hh0cm27agp03i56ob27anp0357iae88b; op553ftclippingsgum=a0750jq0m727ahp07n1jy627ahp0774hk6b18; op553indiahomepageoverlayliid=a03f0hh0cm27agp03i56ob27anp0357iae88b; opClosedOverlayIndia=true; tracerabg=1bUt7Kehl; ft_c=ATYiVieabhIFpjuzZZojVP6UfFE/d2xOxySIHGPoUQgR5dOTsZF2Kcb0H5ud68cpIuHn6OQJrJQrNLY7qVuv7BY; opTrackSess=%26t%3D1; AYSC_C=S; opTrackSessIDOL=%26sesid%3D8E5351D4-55E2-4981-BF50-1CA8EAD1B3C4%26ref%3D0
Cookie: opPageCount=113x1311457328620%26sub%3D1; opFTData=%26v%3D1; FTUserTrack=117.212.66.187.1311457327881589; AYSC=_04karnataka_13IND_14IND_15in_17PVT_18bangalore_24asia_25PVT_26PVT_27PVT_96PVT_98PVT_; GZIP=1; FT_M=D=D,F=,R=0; rsi_segs=J07717_11049|J07717_10702|J07717_10555|J07717_10301|J07717_10982|J07717_11009|J07717_11148|J07717_11189; op553indiahomepageoverlaygum=a03f0hh0cm27agp03i56ob27anp0357iae88b; op553ftclippingsgum=a0750jq0m727ahp07n1jy627ahp0774hk6b18; op553indiahomepageoverlayliid=a03f0hh0cm27agp03i56ob27anp0357iae88b; opClosedOverlayIndia=true; tracerabg=1bUt7Kehl; ft_c=ATYiVieabhIFpjuzZZojVP6UfFE/d2xOxySIHGPoUQgR5dOTsZF2Kcb0H5ud68cpIuHn6OQJrJQrNLY7qVuv7BY; opTrackSess=%26t%3D1; AYSC_C=S; opTrackSessIDOL=%26sesid%3D8E5351D4-55E2-4981-BF50-1CA8EAD1B3C4%26ref%3D0
__END__

=head1 NAME

Util.pl - Describe the usage of script briefly

=head1 SYNOPSIS

Util.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for Util.pl, 

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
