#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.18.2;

use lib 'lib';

use Intern::Diary::CLI qw/input_text/;

my $action = shift;

if ($action eq 'add') {
    my $body = input_text();

    if (!$body) {
        warn "Article text required!!\n";
        exit 1;
    }

    say $body;
}

else {
    warn "Arguments Error!!\n\n";
    warn "  Usage: ./diary.pl [action] [argument...]\n\n";
    exit 1;
}

#given ($ARGV[0])

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
