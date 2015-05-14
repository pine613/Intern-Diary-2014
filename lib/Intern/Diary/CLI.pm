package Intern::Diary::CLI;

use strict;
use warnings;
use utf8;
use 5.18.2;

use Exporter 'import';
use File::Temp qw/tempfile tempdir/;

our @EXPORT_OK = qw/input_text/;

sub input_text {
    my ($fh, $filename) = tempfile();
    my $editor = $ENV{EDITOR} || 'vim';

    system $editor => $filename;

    my $text = do { local $/; <$fh> };
    close $fh;

    return $text;
}

1;
