package t::Intern::Diary::Model;

use strict;
use warnings;
use utf8;
use lib 't/lib';

use parent 'Test::Class';

use Test::Intern::Diary;
use Test::More;

use Intern::Diary::Model::Entry;

sub _use : Test(1) {
    use_ok 'Intern::Diary::Model::Entry';
}

sub _new : Test(5) {
    my $entry;
    my $params = +{
        id => 1,
        title => 'title',
        body => 'body',
        author => 'author',
    };

    ok( $entry = Intern::Diary::Model::Entry->new($params) );
    ok( $entry->{id} == 1 );
    ok( $entry->{title} eq 'title' );
    ok( $entry->{body} eq 'body' );
    ok( $entry->{author} eq 'author' );
}

sub created_at : Test(1) {
    my $entry = Intern::Diary::Model::Entry->new();

    $entry->{created_at} = '2003-01-16 23:12:01';
    isa_ok( $entry->created_at(), 'DateTime' );
}

__PACKAGE__->runtests;

1;
