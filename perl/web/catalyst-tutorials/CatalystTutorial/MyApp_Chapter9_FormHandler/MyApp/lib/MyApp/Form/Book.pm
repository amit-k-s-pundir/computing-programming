package MyApp::Form::Book;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => ( default =>'Books' );

has_field 'title' => ( minlength => 5, maxlength => 40, required => 1 );
has_field 'rating' => ( type => 'Integer', range_start => 1, range_end => 5 );
has_field 'authors' => ( type => 'Multiple', label_column => 'last_name' );
has_field 'submit' => ( type => 'Submit', value => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;
