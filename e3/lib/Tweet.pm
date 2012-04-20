package Tweet;

use strict;
use warnings;

use DateTime;

sub new {
    my $class = shift;
    my %info = @_;
    my $self = {
        owner => $info{owner},
        stamp => DateTime->now,
        message => $info{message},
    };
    return bless $self, $class;
}

# Accessors

sub message {
    my $self = shift;
    return $self->{message};
}

sub stamp {
    my $self = shift;
    return $self->{stamp};
}

sub owner {
    my $self = shift;
    return $self->{owner};
}

sub timestamp {
    my $self = shift;
    return $self->{stamp};
}

1;

