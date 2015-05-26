#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use 5.18.2;

use Encode;
use Data::Dumper;
use Text::ASCIITable;

use lib 'lib';

use Intern::Diary::CLI qw/input_text edit_text/;
use Intern::Diary::DBI::Factory;
use Intern::Diary::Service::Entry;


sub run {
    my ($action, @args) = @_;
    my @actions = ('add', 'list', 'show', 'edit', 'delete');

    $action //= 'error';

    if (grep { $_ eq $action } @actions) {
        my $db = Intern::Diary::DBI::Factory->new();
        my $dbh = $db->dbh('intern_diary');

        &{\&{$action}}($dbh, @args);
    }

    else {
        error();
    }
}

sub add {
    my ($dbh, $title) = @_;

    if (!$title) {
        warn "\nArticle title required!!\n";
        warn "  Usage: ./diary.pl add [title]\n\n";
        exit 1;
    }

    my $body = input_text();

    if (!$body) {
        warn "\nArticle text required!!\n";
        exit 1;
    }

    Intern::Diary::Service::Entry->create(
        $dbh,
        +{
            title => $title,
            body => $body,
            author => $ENV{USER}
        });
}

sub list {
    my $dbh = shift;

    my $entries = Intern::Diary::Service::Entry->find($dbh);

    # 表形式で整形して表示
    my $table = Text::ASCIITable->new();
    $table->setCols('ID', 'Title', 'Created at');
    for my $entry (@$entries) {
        $table->addRow($entry->{id}, $entry->{title}, $entry->{created_at});
    }

    say encode_utf8($table);
}

sub show {
    my ($dbh, $id) = @_;

    my $entry = Intern::Diary::Service::Entry->find_one($dbh, +{ id => $id });

    if (!$entry) {
        warn "\nArticle not found!!\n";
        exit 1;
    }

    say "ID: $entry->{id}";
    say encode_utf8("Title: $entry->{title}");
    say encode_utf8("Author: $entry->{author}");
    say "Created at: $entry->{created_at}";
    say "Updated at: $entry->{updated_at}";
    say encode_utf8("\n$entry->{body}");
}

sub edit {
    my ($dbh, $id) = @_;

    if (!$id) {
        warn "\nArticle ID required!!\n\n";
        warn "  Usage: ./diary.pl edit [ID]\n\n";
        exit 1;
    }

    my $entry = Intern::Diary::Service::Entry->find_one($dbh, +{ id => $id });
    my $body = edit_text($entry->{body});

    Intern::Diary::Service::Entry->update(
        $dbh,
        +{
            id => $id,
            body => $body,
        });
}

sub delete {
    my ($dbh, $id) = @_;


    if (!$id) {
        warn "\nArticle ID required!!\n\n";
        warn "  Usage: ./diary.pl delete [ID]\n\n";
        exit 1;
    }

    Intern::Diary::Service::Entry->delete($dbh, +{ id => $id });
}

sub error {
    warn "\nArguments Error!!\n\n";
    warn "  Usage: ./diary.pl [action] [argument...]\n\n";
    exit 1;
}

run(@ARGV);

__END__

=head1 NAME

diary.pl - コマンドラインで日記を書くためのツール。データはデータベースに書き込みます。

=head1 SYNOPSIS

  $ ./diary.pl [action] [argument...]

=head1 ACTIONS

=head2 C<add>

  $ diary.pl add [title]

日記に記事を書きます。

=head2 C<list>

  $ diary.pl list

日記に投稿された記事の一覧を表示します。

=head2 C<list>

  $ diary.pl show [entry ID]

日記に投稿された記事の詳細を表示します。

=head2 C<edit>

  $ diary.pl edit [entry ID]

指定したIDの記事を編集します。

=head2 C<delete>

  $ diary.pl delete [entry ID]

指定したIDの記事を削除します。

=cut
