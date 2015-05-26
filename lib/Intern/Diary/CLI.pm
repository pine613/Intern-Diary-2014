package Intern::Diary::CLI;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Encode;
use Exporter 'import';
use File::Temp qw/tempfile tempdir/;
use IO::Handle;

our @EXPORT_OK = qw/input_text edit_text/;

sub input_text {
    edit_text();
}

sub edit_text {
    my $text = shift;

    my ($fh, $filename) = tempfile();

    # 現在の内容を書き込む
    print $fh encode_utf8($text) if $text;
    $fh->flush;
    seek $fh, 0, 0;

    # エディタを立ち上げて編集
    my $editor = $ENV{EDITOR} || 'vim';
    system $editor => $filename;

    # 編集後の内容を取得
    do { local $/; <$fh> };
}

1;
