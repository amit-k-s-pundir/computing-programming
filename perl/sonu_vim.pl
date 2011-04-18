#!/usr/bin/perl -w

use strict;
use warnings;

use feature "switch";
use feature ":5.10";

#package sonu::vim;

my $output = "";

&main;

sub main{
   say &xml([":xml",
        [":header"],
        [":html", ":xmlns", "http://www.w3.org/1999/xhtml",
        ":xml-lang", "en-us", ":lang", "en-us",
        [":head",
        [":script", ":type", "text/javascript"],
        [":meta", ":http-equiv", "Content-Type", ":content", "text/html;
        charset=utf-8"],
        [":link"]],
        [":body"]]]);
}


sub xml{
    my $xml_tree_ref = shift;
    my @xml_tree = @{$xml_tree_ref};

    &write_node($xml_tree_ref);
}


#sub do-node{

#    my $output;
#  write-node;
#    my %attrs;
#    my @children;
#  my @node_attrs;

#  write_node_prologue($node). write_node_body($node)
#	. write_node_epilogue($node);

    # sub write_node_prologue{
# 	my $node_name = shift;

#	return "<" . $node_name . write_attrs . ">";
#  }

    #	my(@attr, $attr_value, $node_ref);

        # The value of this state variable indicates whether the last item extracted
        # from the list was a keyword.  If it was indeed a keyword then the value of
        # this variable is that keyword otherwise it is false in boolean context.
#	my $last_keyword_item_state # false initially.

#	while(shift){
#	  given($_){
#		when(keyword? $_){
#		  if($last_keyword_item_state){
#			# the last item retrieved from the list must have been a keyword and
#			# therefore we must first set the value of that keyword attribute
#			# with the current item if it is indeed an appropriate
#			# attribute-value (i.e. it is not another keyword or and array ref);
#			# or null if it is not.  As we now know that the current item is
#			# anothr keyword, we have to set the previous keyword (attribute)
#			# value to null.  Similar logic will be used in all the following
#			# *switch* branches.
#			$attrs{$last_keyword_item_state} = undef;
#			$last_keyword_item_state = $_;
#		  }else{
#			$last_keyword_item_state = $_;
#		  }
#		}
#		when(ref($_) eq "ARRAY"){
#		  if($last_keyword_item_state){
#			$attrs{$last_keyword_item_state} = undef;
#			$last_keyword_item_state = undef;
#		  }
#		  do-node(@->$_);
#		}
#		default{
#		  # If it is not a keyword and not an array ref (i.e. a node child) then
#		  # it must be an attribute value of a previous keyword.
#		  if($last_keyword_item_state){
#			$attrs{$last_keyword_item_state} = $_;
#			$last_keyword_item_state = undef;
#		  }else{
#			# If last item retrieved was not a keyword and we are not a keyword
#			# or an array ref then there is an error here!
        #
        #
#		push(@attrs, $_);
#	  }
#	  }
##		  if(!(keyword?(my $potential_keyword_value = shift)))$attrs{$_} =
#	}continue{

        sub write_node{
            my $node_ref = shift;
            my @node = @{$node_ref};
            #my @input = @_;

            my $node_name = shift @{$node_ref};

            if(&keyword_p($node_name)){
                $output = $output . "<" . symbol_val($node_name);
            }else{
                die "A node should start with a keyword whereas this node's name
                is: $node_name";
            }

            while(my $input = shift @{$node_ref}){
                given($input){
                    when(not defined($input)){
                        return $output = $output . ">";
#                        &state1;
                    }
                    when(&keyword_p($input)){
                        $output = $output . " " . symbol_val($input) . "=";
                        #$output = $output . "<" . symbol_val($input);
                        #goto &state1;
                        &state1($node_ref);
                    }
                    when(node_ref_p($input)){
                        &write_node($input);
                    }
                    when(attr_val_p($input)){
                        die "The first value after a node name can't be an
                        attribute: $input, $!";
                    }
                }
            }

            $output = $output . ">";

            sub state1{
                my $ref = shift;
                my @node = @{$ref};
                my $input = shift @{$ref};

                given($input){
                    when(not defined($input)){
                        return $output = $output . ">";
#                        &state1;
                    }
                    when(keyword_p($input)){
                        $output = $output . "\"\"" . " " . symbol_val($input) . "=";
                        #$output = $output . " " . symbol_val($input) . "=";
                        #goto &state2;
                        &state1;
                    }
                    when(node_ref_p($input)){
                        #goto &write-node($input);
                        $output = $output . "\"\"";
                        &write_node($input);
                    }
                    when(code_ref_p($input)){
                        die "Found code-ref at wrong place: $!";
                    }
                    when(attr_val_p($input)){
                        return $output = $output . $input;
                        #die "Found an attribute value at wrong place: $!";
                    }
                    default{
                        print $input;
                        die "Found a wrong value during parsing: $input $!";
                    }
                }
            }

            sub state2{
                my $input = shift;

                given($input){
                    when(keyword_p($input)){
                        $output = $output . "\"\"" . " " . symbol_val($input) . "=";
                        #$output = $output . " " . symbol-value($input) . "=";
                        #goto &state1;
                        &state1;
                    }
                    when(code_ref_p($input)){
                        $output = $output . &{$input};
                        #goto &state2;
                        &state2;
                    }
                    when(node_ref_p($input)){
                        #goto &write_node;
                        &write_node(@{$input});
                    }
                    when(attr_val_p($input)){
                        $output = $output . $input;
                        #goto &state2;
                        &state2;
                    }

                }
            }

            # Is the argument a valid keyword (e.g. :name, :colour)?
            sub keyword_p{
                my $keyword = shift;

                return $keyword if (index($keyword, ":") == 0);
                return 0;
            }


            sub attr_val_p{
                my $attr = shift;
                
                # return $attr unless keyword_p($attr);
                return $attr;
            }

            sub code_ref_p{
                my $arg = shift;

                return $arg if ref($arg) eq "CODE";
                return 0;
            }

            sub node_ref_p{
                my $arg = shift;

                return $arg if ref($arg) eq "ARRAY";
                return 0;
            }

            sub symbol_val{
                my $arg = shift;

                if($arg =~ /:(.+)/){
                    return $1;
                }
            }


#            sub state2{
#                # Input can be a keyword or a node but not another attr_val? or code-ref?.
#
#                my $input = shift;
#
#                given($input){
#                    when(keyword?($Input)){
#                        $output = $output . "\"\"" . " " . symbol-value($input) . "=";
#                        goto &state1;
#                    }
#                    when(node?($input)){
#                        goto &write_node;
#                    }
#                    default{
#                        die "There was an error in the dsl syntax: $!";
#                    }
#                }
#            }
        }
#}


#  sub write_attrs{
#
#	foreach (
#
#	while(keyword?(@_[0])
#
#
#
#   if(ref($r) eq "ARRAY"
#
#sub write-element{
#  my($elem_ref, $indention) = @_;
#  my @elem = @$elem_ref;
#
#  return "" if null?(elem);
#
#  $elem_str = "<" . symbol-name(shift(@elem)) . write-attr(@elem)
#	. write-value(@elem) . ">";
#  }
#

