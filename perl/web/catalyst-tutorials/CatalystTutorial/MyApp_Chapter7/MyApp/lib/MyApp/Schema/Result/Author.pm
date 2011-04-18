package MyApp::Schema::Result::Author;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn", "Core");
__PACKAGE__->table("author");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "INTEGER",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "first_name",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "last_name",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-05-25 23:58:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NXdFpHVaaGNO+7MEEm/ufw


# You can replace this text with custom content, and it will be preserved on regeneration

#
# Set relationships:
#

# has_many():
#   args:
#     1) Name of relationship, DBIC will create an accessor with this name
#     2) Name of the model class referenced by this relationship
#     3) Column name in *foreign* table (aka, foreign key in peer table)
__PACKAGE__->has_many(book_authors => 'MyApp::Schema::Result::BookAuthor', 'author_id');

# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
__PACKAGE__->many_to_many(books => 'book_authors', 'book');


#
# Helper methods
#
sub full_name {
    my ($self) = @_;

    return $self->first_name . ' ' . $self->last_name;
}


1;
