package Forest;

use strict;
use warnings;

# Exceptions
use Exception::Class (
    'X::DuplicatedBird' => {
        fields => ['name', ],
    },
    'X::BirdExists' => {
        fields => ['name', ],
    },
);

sub X::DuplicatedBird::full_message {
    my $self = shift;
    return qq{Bird name } . $self->{name} . qq{ is duplicated.};
}

sub X::BirdExists::full_message {
    my $self = shift;
    return qq{Bird name } . $self->{name} . qq{ already registered.};
}


# Main Part

sub new {
    my $class = shift;
    my $self = {
        birds => [],
    };
    return bless $self, $class;
}

sub onFollow {
    my ($self, $follower, $followee_name) = @_;
    my $followee = $self->_find_bird_by_name($followee_name, $self->{birds});
    # Check follow duplication
    if (!defined $followee
            or $self->_find_followee_by_name($follower, $followee_name)) {
        return undef;
    }
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
    if ($self->_find_bird_by_name($newbie_name, $self->{birds})) {
        X::BirdExists->throw(name => $newbie_name);
    }
    push @{$self->{birds}}, $newbie;
}

sub _find_bird_by_name {
    my $self = shift;
    my $name = shift;
    my $birds_list = shift;
    my @found = grep { $_->name eq $name; } @{$birds_list};
    if (@found > 1) {
        X::DuplicatedBird->throw(name => $found[0]->name);
    } elsif (@found == 1) {
        return $found[0];
    }
    return undef;
}

sub _find_followee_by_name {
    my $self = shift;
    my $follower = shift;
    my $followee_name = shift;
    return $self->_find_bird_by_name($followee_name, $follower->followees);
}

1;

