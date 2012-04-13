package Forest;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {
        birds => [],
    };
    return bless $self, $class;
}

sub onFollow {
    my ($self, $follower, $followee) = @_;
    $follower->_follow($followee);
    $followee->_followed_by($follower);
    return $self;
}

sub onTweet {
    my ($self, $bird, $message) = @_;
    $bird->_tweet($message);
    return $self;
}

sub onRegister {
    my ($self, $newbie) = @_;
    my $newbie_name = $newbie->name;
    if (grep $newbie_name, @{$self->{birds}}) {
        return undef;
    }
    push @{$self->{birds}}, $newbie;
}

1;

