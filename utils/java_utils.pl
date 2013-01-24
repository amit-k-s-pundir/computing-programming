package JavaUtils;

use Moose;
use Moose::Util::TypeConstraints;

package JavaTestClass;
extends 'JavaRootClass';

has field1 => (
			   is => 'rw',
			   isa => 'Int',
			   required => 1,
			   );


my $meta = _PACKAGE_->meta;

for my $attr ($meta->get_all_attributes){
  print $attr->name, "\n";
}

for my $method ($meta->get_all_methods){
  print $method->fully_qualified_name, "\n";
}

for my $class ($meta->linearized_isa){
  print "$class\n";
}

for my $subclass ($meta->subclasses){
  print "$subclass\n";
}
