#+{
#    default_view    => 'MT',
#}

my $home = Jobeet::Models->get('home');

return {
    database => [
        'dbi:SQLite:' . $home->file('database.db'), '', '',
         {
             sqlite_unicode => 1,
         },
    ],
};