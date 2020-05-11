package Jobeet::Schema::ResultBase;
use v5.20.3;
use strict;
use warnings;
use parent 'DBIx::Class';

__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);

1;
