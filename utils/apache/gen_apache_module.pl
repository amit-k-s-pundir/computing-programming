#!/usr/bin/perl -w
# gen_apache_module.pl --- Generates a skeletal apache module.
# Author: Amit K S Pundir <sonu@localhost>
# Created: 12 Dec 2011
# Version: 0.01

use warnings;
use strict;

#gen_skeletal_apache_module();

my $template_file;

sub gen_skeletal_apache_module{
#    my $template_file = shift;
    
    open(FH, $template_file) && return <FH>;
    return header() . body() . footer();
};

sub header{
    my($c_headers_ref, $cpp_headers_ref) = (shift, shift);
    gen_headers($c_headers_ref, $cpp_headers_ref);
}

sub body{
}

sub footer{
}

sub gen_headers{
    my ($c_headers_ref, $cpp_headers_ref) = (shift, shift);
    my $output = "";

    for my $c_header (@{$c_headers_ref})   {
        $output = $output . "include \"${c_header}\.h\";" . "\n";
    }

    $output = $output . "\n";

    for my $cpp_header(@{$cpp_headers_ref}) {
        $output = $output . "include <${cpp_header}>;" . "\n";
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
