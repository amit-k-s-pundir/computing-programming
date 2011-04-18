package MyApp::Schema::Result::BookAuthor;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("book_author");
__PACKAGE__->add_columns(
  "book_id",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "author_id",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("book_id", "author_id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-11-15 00:41:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mI02j1Vd+Qb+x5S4PEFTKA


# You can replace this text with custom content, and it will be preserved on regeneration

#
# Set relationships:
#

# belongs_to():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *this* table
__PACKAGE__->belongs_to(book => 'MyApp::Schema::Result::Book', 'book_id');

# belongs_to():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *this* table
__PACKAGE__->belongs_to(author => 'MyApp::Schema::Result::Author', 'author_id');

1;
