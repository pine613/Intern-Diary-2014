package t::Intern::Diary::Service;

use strict;
use warnings;
use utf8;
use 5.18.2;

use lib 't/lib';
use parent 'Test::Class';

use Test::Intern::Diary;
use Test::More;
use Data::Dumper;

use Intern::Diary::Service::Entry;
use Intern::Diary::DBI::Factory;

my $dbh = dbh();

sub dbh {
    my $db = Intern::Diary::DBI::Factory->new();
    $db->dbh('intern_diary');
}

sub new_entry {
    Intern::Diary::Service::Entry->create($dbh, +{
        title => 'title',
        body => 'body',
        author => 'author',
    });

    Intern::Diary::Service::Entry->find($dbh)->[0];
}

sub before : Test(setup) {
    $dbh->query(q[ DELETE FROM `entry` ]);
}

sub use : Test(1) {
    use_ok 'Intern::Diary::Service::Entry';
}

sub create : Test(2) {
    my $entry = new_entry();

    ok( $entry->body eq 'body' );
    ok( $entry->author eq 'author' );
}

sub update : Test(1) {
    my $entry = new_entry();

    Intern::Diary::Service::Entry->update($dbh, +{
        id => $entry->id,
        body => 'new_body',
    });

    my $updated_entry = Intern::Diary::Service::Entry->find_one($dbh, +{ id => $entry->id });

    ok( $updated_entry->body eq 'new_body' );
}

sub delete : Test(1) {
    my $entry = new_entry();

    Intern::Diary::Service::Entry->delete($dbh, +{
        id => $entry->id,
    });

    my $deleted_entry = Intern::Diary::Service::Entry->find_one($dbh, +{ id => $entry->id });

    ok( not $deleted_entry );
}

__PACKAGE__->runtests;

1;
