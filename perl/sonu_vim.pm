use strict;
use warnings;

use feature "switch";
use feature ":5.10";

package sonu::vim;

&main;

sub main{
   print xml([
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

    &write_node(@xml_tree);
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
            #my @input = @_;
            my $output;

            while(my $input = shift){
                given($input){
                    when(&keyword_p($input)){
                        $output = $output . "<" . symbol_value($input);
                        #goto &state1;
                        &state1;
                    }
                    when(attr_val_p($input)){
                        die "A node should start with a keyword - the node's name: $!";
                    }
                    when(node_ref_p($input)){
                        die "A node should start with a keyword - the node's name: $!";
                    }
                }
            }

            sub state1{
                my $input = shift;

                given($input){
                    when(keyword_p($input)){
                        $output = $output . " " . symbol_value($input) . "=";
                        #goto &state2;
                        &state2;
                    }
                    when(node_ref_p($input)){
                        #goto &write-node($input);
                        &write_node($input);
                    }
                    when(attr_value_p($input)){
                        die "Found an attribute value at wrong place: $!";
                    }
                    when(code_ref_p($input)){
                        die "Found code-ref at wrong place: $!";
                    }
                    default{
                        die "Found a wrong value during parsing: $!";
                    }
                }
            }

            sub state2{
                my $input = shift;

                given($input){
                    when(keyword_p($input)){
                        $output = $output . "\"\"" . " " . symbol_value($input) . "=";
                        #$output = $output . " " . symbol-value($input) . "=";
                        #goto &state1;
                        &state1;
                    }
                    when(attr_val_p($input)){
                        $output = $output . $input;
                        #goto &state2;
                        &state2;
                    }
                    when(code_ref_p($input)){
                        $output = $output . &{$input};
                        #goto &state2;
                        &state2;
                    }
                    when(node_ref_p($input)){
                        #goto &write_node;
                        &write_node;
                    }
                }
            }

            # Is the argument a valid keyword (e.g. :name, :colour)?
            sub keyword_p{
                my $keyword = shift;

                return $keyword unless (index($keyword, ":") == 0);
                return 0;
            }


            sub attr_val_p{
                my $attr = shift;
                
                return $attr unless keyword_p($attr);
                return 0;
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

