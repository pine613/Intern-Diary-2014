package Intern::Diary::Service::Entry;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Intern::Diary::DBI::Factory;
use Intern::Diary::Model::Entry;
use DateTime;
use Data::Dumper;

sub create {
    my ($class, $dbh, $args) = @_;

    $dbh->query(q[
        INSERT INTO `entry`
            SET
                `title` = :title,
                `body` = :body,
                `author` = :author,
                `created_at` = :created_at
    ], +{
        title => $args->{title},
        body => $args->{body},
        author => $args->{author},
        created_at => DateTime->now(),
    });
}

sub update {
    my ($class, $dbh, $args) = @_;

    $dbh->query(q[
        UPDATE `entry`
            SET
                `body` = :body
            WHERE
                `id` = :id
    ], +{
        id => $args->{id},
        body => $args->{body},
    });
}

sub find {
    my ($class, $dbh, $args) = @_;

    my $entries = $dbh->select_all(q[
        SELECT * FROM `entry`
    ]);

    [ map { Intern::Diary::Model::Entry->new($_) } @$entries ];
}

sub find_one {
    my ($class, $dbh, $args) = @_;

    my $entry = $dbh->select_row(q[
        SELECT * FROM `entry`
            WHERE
                `id` = :id
    ], +{
        id => $args->{id},
    });

    $entry && Intern::Diary::Model::Entry->new($entry);
}

sub delete {
    my ($class, $dbh, $args) = @_;

    $dbh->query(q[
        DELETE FROM `entry`
            WHERE
                `id` = :id
    ], +{
        id => $args->{id},
    });
}

1;

