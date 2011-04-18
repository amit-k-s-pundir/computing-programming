function! Perl_fun()
perl << EOF

use strict;
use warnings;

use feature ":5.10";
use feature "switch";

BEGIN{
    push @INC, '/home/sonu/workspace/programming/perl/lib';
}

#no Sonu::Vim::Greasemonkey;
use Sonu::Vim::Greasemonkey;

my $buff = $curwin->Buffer();
#$curbuf->Append("$", gen_banner("test", "http://localhost/greasemonkey/", "display form submission URL as a tooltip of submit button", ""));
VIM::Msg(gen_banner("name", "ns", "desc", "include"));
$curbuf->Append(32, gen_banner("name", "ns", "desc", "include"));

#VIM::Msg(gen_banner("test", "http://localhost/greasemonkey/", "display form submission URL as a tooltip of submit button", ""));
VIM::Msg("hello");

EOF
endfunction

call Perl_fun()
