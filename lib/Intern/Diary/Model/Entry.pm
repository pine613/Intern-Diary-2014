package Intern::Diary::Model::Entry;

use strict;
use warnings;
use utf8;

use Class::Accessor::Lite (
    new => 1,
    ro => [ qw/id title body author/ ]
);
