# gen_apache_module.pm --- Generates a skeletal apache module.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 12 Dec 2011
# Version: 0.01

package Apache::Module::Gen;

use warnings;
use strict;

use Exporter 'import';
# @EXPORT_OK = ();

#gen_skeletal_apache_module();

my $template_file;

sub gen_skeletal_apache_module{
#    my $template_file = shift;

    open(FH, $template_file) && return <FH>;
    return mod_header() . mod_body() . mod_footer();
};

sub mod_header{
    my($c_headers_ref, $cpp_headers_ref) = (shift, shift);
    gen_includes($c_includes_ref, $cpp_includes_ref);
}

sub mod_body{
    my $body = "";
    $body .= <<EOF;
module AP_MODULE_DECLARE_DATA $mod_name;

static int filter_init(ap_filter_t* f){
}

EOF
    return $body;
    
}

sub mod_footer{
}

# Don't write this code in perl as code generation programs can
# typically use the code generation/meta-programming facilities which
# are not easily available in Perl. The implementation of this
# function is one such use case for metaprogramming. Just use a Lisp!
sub gen_includes{
    my ($c_includes_ref, $cpp_includes_ref) = (shift, shift);
    my $output = "";

    unless ( defined $c_includes_ref) {
        $c_includes_ref = [qw(apr_want, apr_lib, apr_strings,
                              apr_hash, httpd, http_config
        http_request http_log ap_expr)];
    };
    unless (defined $cpp_includes_ref) {
        $cpp_includes_ref = [qw(string vector iostream fstream
        boost/lambda)];
    }
    for my $c_include (@{$c_includes_ref})   {
        $output = $output . "include \"${c_include}\.h\";" . "\n";
    }

    $output = $output . "\n";

    for my $cpp_header(@{$cpp_headers_ref}) {
        $output = $output . "include <${cpp_header}>\.hpp\";" . "\n";
    }
    return $output;
}

1;

__END__

=head1 NAME

gen_apache_module.pl - Describe the usage of script briefly

=head1 SYNOPSIS

gen_apache_module.pl [options] args

      -opt --long      Option description

=head1 DESCRIPTION

Stub documentation for gen_apache_module.pl, 

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
