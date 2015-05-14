#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use 5.18.2;

use lib 'lib';

use Intern::Diary::CLI qw/input_text/;
use Intern::Diary::Service::Entry;
use Intern::Diary::DBI::Factory;


sub run {
    my ($action, @args) = @_;
    my @actions = ('add', 'list', 'edit', 'delete');

    if (grep { $_ eq $action } @actions) {
        my $db = Intern::Diary::DBI::Factory->new();
        &{\&{$action}}($db->dbh('local'), @args);
    }

    else {
        error();
    }
}

sub add {
    my ($dbh, $title) = @_;

    say $dbh;

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

    say $title;
    say $body;
}

sub list {


}

sub edit {
    my $id = shift;

    if (!$id) {
        warn "\nArticle ID required!!\n\n";
        warn "  Usage: ./diary.pl edit [ID]\n\n";
        exit 1;
    }

}

sub delete {
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

=head2 C<edit>

  $ diary.pl edit [entry ID]

指定したIDの記事を編集します。

=head2 C<delete>

  $ diary.pl delete [entry ID]

指定したIDの記事を削除します。

=cut
