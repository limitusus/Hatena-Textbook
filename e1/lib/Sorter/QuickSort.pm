package Sorter::QuickSort;

use strict;
use warnings;
use base "Sorter";

sub new {
    my $class = shift;
    my $self = $class->SUPER::new();
    return $self;
}

sub sort {
    my $self = shift;
    my @result = $self->get_values;
    # Quicksort!
    @result = qs(@result);
    $self->values(\@result);
}

sub qs {
    my @v = @_;
    return () if scalar(@v) == 0;
    my (@left, @mid, @right) = ((), (), ());
    my $pivot = $v[0];
    #print STDERR "@v: $pivot\n";
    for my $k (@v) {
        if ($k == $pivot) {
            push @mid, $k;
        } elsif ($k < $pivot) {
            push @left, $k;
        } else {
            push @right, $k;
        }
    }
    return (qs(@left), @mid, qs(@right));
}

1;

