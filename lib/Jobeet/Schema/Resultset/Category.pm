package Jobeet::Schema::ResultSet::Category;
use strict;
use warnings;
use parent 'DBIx::Class::ResultSet';

use Jobeet::Models;

sub get_with_jobs {
	my $self = shift;
	my $attr = shift || {};

	$attr->{rows} ||= 10;

	$self->jobs(
	    { expires_at => { '>=', models('Schema')->now->strftime("%F %T") } },
	    {   order_by => { -desc => 'created_at' },
	        rows     => $attr->{rows},
	    }
	);

1;