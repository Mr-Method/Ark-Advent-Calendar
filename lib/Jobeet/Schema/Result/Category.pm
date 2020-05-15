package Jobeet::Schema::Result::Category;
use v5.20.3;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';

__PACKAGE__->table('jobeet_category');

__PACKAGE__->add_columns(
    id => {
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
    },
    name => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['name']);

#リレーションの定義
__PACKAGE__->has_many( jobs => 'Jobeet::Schema::Result::Job', 'category_id' );
__PACKAGE__->has_many(
    category_affiliate => 'Jobeet::Schema::Result::CategoryAffiliate', 'category_id');

#連鎖的なデリート防ぐ
__PACKAGE__->has_many(
    category_affiliate => 'Jobeet::Schema::Result::CategoryAffiliate', 'category_id',
    {
        is_foreign_key_constraint   => 0,
        cascade_delete              => 0,
    },
);

sub get_active_jobs {
    my $self = shift;

    $self->jobs(
        { expires_at => { '>=', models('Schema')->now } },
        { order_by => { -desc => 'created_at' } }
    );
}

1;
