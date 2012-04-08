package Sorter;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {};
    $self->{values} = [];
    return bless $self, $class;
}

sub values {
    my $self = shift;
    my $newval = shift;
    if (defined $newval) {
        $self->{values} = $newval;
    }
    return $self->{values};
}

sub get_values {
    my $self = shift;
    return @{$self->values};
}

sub set_values {
    my $self = shift;
    my @values = @_;  # Copy deeply
    $self->{values} = \@values;
}

sub sort {
    my $self = shift;
    my @sorted = sort { $a <=> $b } @{$self->values};
    $self->{values} = \@sorted;
}

1;

