package Tweet;

use strict;
use warnings;

use DateTime;
use Time::HiRes;

sub new {
    my $class = shift;
    my %info = @_;
    my $stamp = Time::HiRes::time();
    my $self = {
        owner => $info{owner},
        stamp => DateTime->from_epoch(epoch => $stamp),
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

