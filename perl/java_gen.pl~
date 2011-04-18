#!/usr/bin/perl

use strict;

use feature 'state';
use feature "switch";
use feature ":5.10";

say &write_java_type({kind => "interface", name => "TestInterface",
            access_modifier => "public", static_modifier => "",
            has_superinterfaces_p => 0, functions => {}, slots => {}, prologue
            => "", epilogue => ""});


=pod

Arg: A reference to a hash.
    <i>arg1</i> : (kind => <i>(interface | class)</i>, functions =>
    <i>functions</i>, slots => <i>slots</i>, prologue => <i>(\w)*</i>, epilogue
    => <i>(\w)*</i>, epilogue => <i>(\w)*</i>, unit_test? => <i>(t|f)</i>)

=cut

sub write_java_type{
    my $ostr = "";
    my $hash_ref = shift;
    my $prologue_str = ${hash_ref}->{prologue} || "/**\n*\n*\n*/\n";
    my $epilogue_str = ${hash_ref}->{epilogue};
    my($found_kind_p, $found_functions_p, $found_slots_p, $found_prologue_p,
        $found_epilogue_p, $found_nested_types_p); 

    foreach my $key (keys %{$hash_ref}){
        given($key){
            when(/^kind$/){
                $found_kind_p = 1;
                $ostr = $ostr . ${hash_ref}->{access_modifier} . " " . 
                ${hash_ref}->{storage_modifier} . " " .
                ${hash_ref}->{kind} . " " . ${hash_ref}->{name} .
                (${hash_ref}->{has_superclasses_p}?("extends" . 
                (join (" ", ${hash_ref}->{superclasses})))
                :${hash_ref}->{has_superinterfaces_p}?("implements" . 
                (join (" ", ${hash_ref}->{interfaces}))):"");
            }
        }
    }
    return $prologue_str . "{\n" . $ostr . "\n}" . $epilogue_str;
}


  
