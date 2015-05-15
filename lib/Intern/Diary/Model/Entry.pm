package Intern::Diary::Model::Entry;

use strict;
use warnings;
use utf8;

use DateTime::Format::MySQL;

use Class::Accessor::Lite (
    new => 1,
    ro => [ qw/id title body author/ ]
);

sub _date_prop {
    my ($self, $prop) = @_;

    $self->{"_$prop"} ||= eval {
        my $dt = DateTime::Format::MySQL->parse_datetime($self->{$prop});
        $dt->set_time_zone('UTC');
        $dt->set_formatter(DateTime::Format::MySQL->new);
        $dt;
    };
}

sub created_at {
    my $self = shift;
    $self->_date_prop('created_at');
}

sub updated_at {
    my $self = shift;
    $self->_date_prop('updated_at');
}

1;
