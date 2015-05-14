package Intern::Diary::Service::Diary;

use strict;
use warnings;
use utf8;

use Intern::Diary::DBI::Factory;
use SQL::NamedPlaceholder;
use DateTime;

sub add {
    my ($dbh, $title, $body) = @_;

    my ($sql, $bind) = SQL::NamedPlaceholder::bind_named(q[
        INSERT INTO `entry`
            SET
                title = :title,
                body = :body,
                created_at = :created_at
    ], +{
        title => $title,
        body => $body,
        created_at => DateTime->now()
    });
}

1;
